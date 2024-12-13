package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author Redamancy
 * @description 针对表【EmotionalIntelligence】的数据库操作Mapper
 * @createDate 2024-12-09 16:06:08
 * @Entity fun.redamancyxun.eqmaster.backend.entity.EmotionalIntelligence
 */
@Mapper
public interface EmotionalIntelligenceMapper extends BaseMapper<EmotionalIntelligence> {
}
