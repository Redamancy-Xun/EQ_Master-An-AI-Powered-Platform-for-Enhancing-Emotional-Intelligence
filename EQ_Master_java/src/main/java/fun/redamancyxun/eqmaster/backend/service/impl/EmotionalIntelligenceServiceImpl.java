package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence;
import fun.redamancyxun.eqmaster.backend.entity.Star;
import fun.redamancyxun.eqmaster.backend.mapper.EmotionalIntelligenceMapper;
import fun.redamancyxun.eqmaster.backend.service.EmotionalIntelligenceService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmotionalIntelligenceServiceImpl implements EmotionalIntelligenceService {

    @Autowired
    private EmotionalIntelligenceMapper emotionalIntelligenceMapper;

    @Autowired
    private UserServiceImpl userService;

    @Autowired
    private SessionUtils sessionUtils;

    /**
     * 获取用户历史EQ
     *
     * @return List<EmotionalIntelligence>
     */
    @Override
    public List<EmotionalIntelligence> getEQHistory() {
        // TODO 是否需要提供更多信息
        String userId = sessionUtils.getUserId();
        QueryWrapper<EmotionalIntelligence> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.isNull("delete_time");
        return emotionalIntelligenceMapper.selectList(queryWrapper);
    }

    /**
     * 定时更新用户EQ
     */
    @Override
    @Scheduled(cron = "0 0 0 * * ?")
    public void updateEQ() {
        // TODO 设计更新EQ的策略（AI + 算法）
    }
}
