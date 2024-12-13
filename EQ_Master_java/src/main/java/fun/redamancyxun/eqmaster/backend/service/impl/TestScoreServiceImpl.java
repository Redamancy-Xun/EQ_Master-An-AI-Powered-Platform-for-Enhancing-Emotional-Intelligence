package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.service.NoticeService;
import fun.redamancyxun.eqmaster.backend.entity.TestScore;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.TestScoreMapper;
import fun.redamancyxun.eqmaster.backend.service.TestScoreService;
import fun.redamancyxun.eqmaster.backend.service.UserService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TestScoreServiceImpl implements TestScoreService {

    @Autowired
    private TestScoreMapper testScoreMapper;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private UserService userService;

    @Autowired
    private NoticeService noticeService;

    /**
     * 创建测验分数
     * @param testId
     * @param score
     * @return TestScore
     */
    @Override
    public TestScore createTestScore(String testId, Double score) {

        String userId = sessionUtils.getUserId();

        TestScore testScore = TestScore.builder()
                .testId(testId)
                .userId(userId)
                .score(score)
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .build();

        // TODO 添加通知考卷名称
        Map<String, String> testNameMap = new HashMap<>();
        String message = "您完成了测试：" +testNameMap.get(testId) + "，分数为：" + score;
        noticeService.SysSend(testId, userId, 0, message, null);

        if (testScoreMapper.insert(testScore) == 0) {
            throw new MyException(EnumExceptionType.INSERT_FAILED);
        }

        return testScore;
    }

    /**
     * 获取用户的所有测验分数记录
     * @return List<TestScore>
     */
    @Override
    public List<TestScore> getTestScoreHistory() {

        // TODO 是否需要提供更多数据？

        String userId = sessionUtils.getUserId();
        QueryWrapper<TestScore> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.isNull("delete_time");
        queryWrapper.orderByDesc("create_time");
        return testScoreMapper.selectList(queryWrapper);
    }

    /**
     * 获取用户所有测验分数
     * @return Map<String, Double>
     */
    @Override
    public Map<String, Double> getUserTotalScore() {

        Map<String, Double> scoreMap = new HashMap<>();
        List<TestScore> testScores = getTestScoreHistory();

        for (TestScore testScore : testScores) {
            String testId = testScore.getTestId();
            Double score = testScore.getScore();
            if (!scoreMap.containsKey(testId)) {
                scoreMap.put(testId, score);
            }
        }

        return scoreMap;
    }

    /**
     * 获取用户某个测验分数
     * @param testId
     * @return Double
     */
    @Override
    public Double getUserTestScore(String testId) {
        QueryWrapper<TestScore> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", sessionUtils.getUserId());
        queryWrapper.eq("test_id", testId);
        queryWrapper.isNull("delete_time");
        queryWrapper.orderByDesc("create_time");
        TestScore testScore = testScoreMapper.selectList(queryWrapper).get(0);
        if (testScore == null) {
            throw new MyException(EnumExceptionType.TESTSCORE_NOT_EXIST);
        }
        return testScore.getScore();
    }

}
