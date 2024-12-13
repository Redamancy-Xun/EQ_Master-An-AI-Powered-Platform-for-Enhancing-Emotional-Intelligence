package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.Reply;
import org.apache.ibatis.annotations.Mapper;

/**
* @author Redamancy
* @description 针对表【reply（回复）】的数据库操作Mapper
* @createDate 2024-12-09 16:06:08
* @Entity fun.redamancyxun.eqmaster.backend.entity.Reply
*/
@Mapper
public interface ReplyMapper extends BaseMapper<Reply> {

}




