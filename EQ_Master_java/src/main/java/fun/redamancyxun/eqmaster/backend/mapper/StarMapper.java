package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.Star;
import org.apache.ibatis.annotations.Mapper;

/**
* @author Redamancy
* @description 针对表【star（收藏）】的数据库操作Mapper
* @createDate 2024-04-01 22:38:40
* @Entity fun.redamancyxun.eqmaster.backend.entity.Star
*/
@Mapper
public interface StarMapper extends BaseMapper<Star> {

}




