package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.Comment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
* @author Redamancy
* @description 针对表【comment（评论）】的数据库操作Mapper
* @createDate 2024-12-09 16:06:08
* @Entity fun.redamancyxun.eqmaster.backend.entity.Comment
*/
@Mapper
public interface CommentMapper extends BaseMapper<Comment> {

    // 根据帖子ID查询评论，按热度排序
    @Select("SELECT * FROM comment " +
            "WHERE daily_share_id = #{dailyShareId} AND delete_time is NULL " +
            "ORDER BY top DESC , likes + reply DESC, create_time DESC")
    List<Comment> selectByPopularity(@Param("dailyShareId") String dailyShareId);

}




