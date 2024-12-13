package fun.redamancyxun.eqmaster.backend.service;


import fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence;

import java.util.List;

public interface EmotionalIntelligenceService {

    // 获取用户的情商历史记录
    public List<EmotionalIntelligence> getEQHistory();

    // 定时更新情商值
    public void updateEQ();
}
