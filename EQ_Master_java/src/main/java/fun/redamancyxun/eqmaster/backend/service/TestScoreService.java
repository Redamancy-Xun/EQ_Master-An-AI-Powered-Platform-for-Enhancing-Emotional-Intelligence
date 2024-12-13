package fun.redamancyxun.eqmaster.backend.service;

import fun.redamancyxun.eqmaster.backend.entity.TestScore;

import java.util.List;
import java.util.Map;

public interface TestScoreService {

    // 创建测验分数
    TestScore createTestScore(String testId, Double score);

    // 获取用户的所有测验分数记录
    List<TestScore> getTestScoreHistory();

    // 获取用户所有测验分数
    Map<String, Double> getUserTotalScore();

    // 获取用户某个测验分数
    Double getUserTestScore(String testId);
}
