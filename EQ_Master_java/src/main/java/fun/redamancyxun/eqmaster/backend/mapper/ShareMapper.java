package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.Share;
import org.apache.ibatis.annotations.Mapper;

/**
 * @author Redamancy
 * @description 针对表【share（转发）】的数据库操作Mapper
 * @createDate 2024-04-06 02:36:40
 * @Entity fun.redamancyxun.eqmaster.backend.entity.Share
 */
@Mapper
public interface ShareMapper extends BaseMapper<Share> {
}
