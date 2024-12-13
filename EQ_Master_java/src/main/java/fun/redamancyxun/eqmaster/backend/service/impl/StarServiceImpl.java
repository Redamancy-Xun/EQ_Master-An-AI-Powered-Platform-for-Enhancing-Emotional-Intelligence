package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.response.DailyShareInfo;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.entity.Star;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.mapper.StarMapper;
import fun.redamancyxun.eqmaster.backend.service.*;
import fun.redamancyxun.eqmaster.backend.util.PageUtils;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Redamancy
 * @description 针对表【star（收藏）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class StarServiceImpl implements StarService {

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private StarMapper starMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private LikeService likeService;

    @Autowired
    private ShareService shareService;

    @Autowired
    private NoticeService noticeService;

    /**
     * 收藏每日分享
     * @param dailyShareId 每日分享id
     * @return 是否收藏成功
     * @throws MyException 通用异常
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Boolean starDailyShare(String dailyShareId) throws MyException {
        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
        String userId = sessionUtils.getUserId();
        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
        }

        QueryWrapper<Star> starQueryWrapper = new QueryWrapper<>();
        starQueryWrapper.eq("user_id", userId);
        starQueryWrapper.eq("daily_share_id", dailyShareId);
        starQueryWrapper.isNull("delete_time");
        if (starMapper.selectCount(starQueryWrapper) != 0) {
            throw new MyException(EnumExceptionType.STAR_EXIST);
        }

        Star star = Star.builder()
                .userId(userId)
                .createTime(LocalDateTime.now())
                .dailyShareId(dailyShareId)
                .deleteTime(null)
                .build();
        if (starMapper.insert(star) == 0) {
            throw new MyException(EnumExceptionType.STAR_FAILED);
        }

        dailyShare.setFavorite(dailyShare.getFavorite() + 1);
        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

//        // 通知
//        String message = "用户" + userService.getUserById(userId).getUsername() + "收藏了您的每日分享";
//        if (!userId.equals(dailyShare.getUserId())) {
//            noticeService.SysSend(dailyShare.getId(), dailyShare.getUserId(), 7, message, userId);
//        }

        return true;
    }

    /**
     * 取消收藏
     * @param dailyShareId 每日分享id
     * @return 是否取消收藏成功
     */
    @Transactional(rollbackFor = MyException.class)
    @Override
    public Boolean unstarDailyShare(String dailyShareId) {
        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
        }

        QueryWrapper<Star> starQueryWrapper = new QueryWrapper<>();
        starQueryWrapper.eq("user_id", sessionUtils.getUserId());
        starQueryWrapper.eq("daily_share_id", dailyShareId);
        starQueryWrapper.isNull("delete_time");

        Star star = starMapper.selectOne(starQueryWrapper);
        if (star == null) {
            throw new MyException(EnumExceptionType.UNSTAR_EXIT);
        }
        star.setDeleteTime(LocalDateTime.now());
        if (starMapper.updateById(star) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        dailyShare.setFavorite(dailyShare.getFavorite() - 1);
        if (dailyShareMapper.updateById(dailyShare) == 0) {
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return true;
    }

    /**
     * 检查用户是否收藏了该每日分享
     * @param dailyShareId 每日分享id
     * @return 是否收藏
     */
    @Override
    public Boolean check(String dailyShareId, String userId) {
        QueryWrapper<Star> starQueryWrapper = new QueryWrapper<>();
        starQueryWrapper.eq("user_id", userId);
        starQueryWrapper.eq("daily_share_id", dailyShareId);
        starQueryWrapper.isNull("delete_time");
        return starMapper.selectOne(starQueryWrapper) != null;
    }

    /**
     * 获取用户收藏的每日分享列表
     * @param page 页数
     * @param pageSize 每页大小
     * @return 每日分享列表
     */
    @Override
    public List<DailyShareInfo> getStarList(Integer page, Integer pageSize) {
        if (page == null || page < 1) {
            page = 1;
        }
        if (pageSize == null || pageSize < 1) {
            pageSize = 10;
        }

        QueryWrapper<Star> starQueryWrapper = new QueryWrapper<>();
        starQueryWrapper.eq("user_id", sessionUtils.getUserId());
        starQueryWrapper.isNull("delete_time");
        List<Star> starList = starMapper.selectList(starQueryWrapper);

        List<DailyShareInfo> dailyShareInfos = new ArrayList<>();
        for (Star star : starList) {
            DailyShare dailyShare = dailyShareMapper.selectById(star.getDailyShareId());
            if (dailyShare.getDeleteTime() != null) {
                continue;
            }
//            User user = userService.getUserById(dailyShare.getUserId());
            Boolean isLike = likeService.check(dailyShare.getId(), 0);
            Boolean isStar = check(dailyShare.getId(), sessionUtils.getUserId());
            Boolean isShare = shareService.check(dailyShare.getId(), sessionUtils.getUserId());
            dailyShareInfos.add(new DailyShareInfo(dailyShare, isLike, isStar, isShare));
        }

        //方便！！！
        return PageUtils.splitList(page, pageSize, dailyShareInfos);
    }
}
