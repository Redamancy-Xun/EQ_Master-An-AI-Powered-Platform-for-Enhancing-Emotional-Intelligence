import createTag from '../utils/helpers/html_elements';
import AnimationItem from './AnimationItem';
import displaySync from '@ohos.graphics.displaySync'
import animator from '@ohos.animator';
import fs from '@ohos.file.fs';
import bez from '../utils/bez';
import { LogUtil } from '../utils/LogUtil'

const animationManager = (function(){
    var moduleOb = {};
    var registeredAnimations = [];
    var playingAnimationsNum = 0;
    var _looperStopped = true;
    var _packageName = '';
    var _playingFrameRate = 0;
    var _userPlayingFrameRate = 0;
    var _looper = null;

    // web only
    function registerAnimation(element, animationData) {
        if (!element) {
            return null;
        }

        let len = registeredAnimations.length
        for (let i = 0; i < len; i++) {
            if (registeredAnimations[i]?.elem !== null && registeredAnimations[i]?.elem === element) {
                return registeredAnimations[i]?.animation;
            }
        }

        var animItem = new AnimationItem();
        setupAnimation(animItem, element);
        animItem.setData(element, animationData);
        return animItem;
    }

    // web only
    function getRegisteredAnimations() {
        var animations = [];
        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            animations.push(registeredAnimations[i]?.animation);
        }
        return animations;
    }

    function pickMaxFrameRate() {
        let maxFrameRate = 0;
        let len = registeredAnimations.length;
        for (let i = 0; i < len; i++) {
            let animItem = registeredAnimations[i]?.animation;
            if (!animItem._idle) {
                let fr = animItem.getFrameRate();
                LogUtil.info(`<${animItem.packageName}>--lottie_ohos check fr from ${animItem.name} with ${fr} fps. running fr is ${_playingFrameRate}`);
                if (fr > maxFrameRate) {
                    maxFrameRate = fr;
                }
            }
        }

        if (_userPlayingFrameRate > 0 && _userPlayingFrameRate < maxFrameRate) {
            return _userPlayingFrameRate; // user already set lower frame rate. so ignore content fr for better performance
        }

        return maxFrameRate;
    }

    function addPlayingCount() {
        playingAnimationsNum += 1;
        if (playingAnimationsNum > 0) {
            activate();
        }
    }

    function subtractPlayingCount() {
        playingAnimationsNum -= 1;
        if (playingAnimationsNum <= 0) {
            deactivate()
        }
    }

    function onAnimationItemLoaded(animItem) {
        LogUtil.info(`<${animItem.packageName}>--lottie_ohos animation created: ${animItem.name} with ${animItem.frameRate} fps`)

        _packageName = animItem.packageName;
    }

    function onAnimationItemDestroy(ev) {
        let animItem = ev.target;
        let len = registeredAnimations.length
        for (let i = len - 1; i >= 0; i--) {
            if (registeredAnimations[i]?.animation === animItem) {
                registeredAnimations[i].animation = null;
                registeredAnimations.splice(i, 1);
                LogUtil.info(`<${animItem.packageName}>--lottie_ohos animation destroyed: ${animItem.name} with ${animItem.frameRate} fps`)
            }
        }

        if (registeredAnimations.length <= 0) {
            deactivate();
        }
    }

    function onAnimationItemActive(animItem) {
        LogUtil.info(`<${animItem.packageName}>--lottie_ohos animation activated: ${animItem.name} with ${animItem.getFrameRate()} fps`)

        if (animItem.getFrameRate() > _playingFrameRate) {
            //有更高帧率的动画活动，需要刷新帧率
            let fr = pickMaxFrameRate();
            requestAnimatorFrameRateIfNeeded(fr);
        }

        addPlayingCount()
    }

    function onAnimationItemIdle(animItem) {
        LogUtil.info(`<${animItem.packageName}>--lottie_ohos animation deactivated: '${animItem.name}' with ${animItem.getFrameRate()} fps`)

        subtractPlayingCount()

        if (animItem.getFrameRate() >= _playingFrameRate) {
            //最高帧率的动画暂停，需要刷新为第二高的帧率值
            let fr = pickMaxFrameRate();
            requestAnimatorFrameRateIfNeeded(fr);
        }
    }

    function destroyOldAnimation(params) {
        let len = registeredAnimations.length;
        let node = params.container?.canvas;
        if (node) {
            let id = node.getUniqueId();
            for (let i = 0; i < len; i += 1) {
                let animation = registeredAnimations[i]?.animation;
                if (id === animation?.wrapper?.canvas?.getUniqueId()) {
                    LogUtil.info(`'${animation.packageName}-${animation.name}'--lottie_ohos destroy animations ${animation.name} from ${animation.source},
          context2D is ${id}, because animation using the same context2D. `);
                    animation.destroy();
                }
            }
        }
    }

    function setupAnimation(animItem, element) {
        animItem.addEventListener('destroy', onAnimationItemDestroy);
        animItem.addEventListener('_active', onAnimationItemActive);
        animItem.addEventListener('_idle', onAnimationItemIdle);
        animItem.addEventListener('DOMLoaded', onAnimationItemLoaded);
        registeredAnimations.push({ elem: element, animation: animItem });
    }

    function loadAnimation(params) {
        LogUtil.info(`<${params.packageName ? params.packageName : ""}>--lottie_ohos loadAnimation. ${params.name ? params.name : ""}`
            + `${params.uri ? " from " + params.uri : (params.path ? " from " + params.path : "")}`);
        destroyOldAnimation(params);
        var animItem = new AnimationItem();
        setupAnimation(animItem, null);
        animItem.setParams(params);
        return animItem;
    }

    function setSpeed(val, animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos setSpeed.${val}, ${animationName ? animationName : ""}`);
        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.setSpeed(val, animationName);
            }
        }
    }

    function setDirection(val, animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos setDirection.${val}, ${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.setDirection(val, animationName);
            }
        }
    }

    function play(animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos play.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.play(animationName);
            }
        }
    }

    function resume(timeStamp, displaySynced) {
        let len = registeredAnimations.length;
        // LogUtil.debug(`<${_packageName}>--lottie_ohos resume: ${timeStamp.toFixed(0)} for total ${len} animation(s)`);

        for (let i = 0; i < len; i += 1) {
            registeredAnimations[i]?.animation.resume(timeStamp, displaySynced);
        }
    }

    function pause(animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos pause.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.pause(animationName);
            }
        }
    }

    function goToAndStop(value, isFrame, animationName) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos goToAndStop.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.goToAndStop(value, isFrame, animationName);
            }
        }
    }

    function stop(animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos stop.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.stop(animationName);
            }
        }
    }

    function togglePause(animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos togglePause.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.togglePause(animationName);
            }
        }
    }

    /**
     * 设置packageName
     * @param name 应用的包名
     */
    function setPackageName(name) {
        LogUtil.info(`<${_packageName}>--lottie_ohos setPackageName.${name}`);
        _packageName = name;
    }

    /**
     * 设置所有动画的最大播放帧率
     * @param frameRate 帧率
     */
    function setMaxFrameRate(frameRate) {
        LogUtil.info(`<${_packageName}>--lottie_ohos setMaxFrameRate: ${frameRate}`);
        _userPlayingFrameRate = frameRate;

        let maxFr = pickMaxFrameRate();
        requestAnimatorFrameRateIfNeeded(maxFr);
    }

    function requestAnimatorFrameRateIfNeeded(frameRate) {
        let looper = getSingletonLooper();
        if (frameRate === 0) {
            LogUtil.info(`<${_packageName}>--lottie_ohos cancel fr request.`)
            deactivate();
            return
        }

        if (frameRate !== _playingFrameRate) {
            if (frameRate > 0 && frameRate <= 120) {
                _playingFrameRate = frameRate;
                let expectedFrameRate = {
                    min: 0,
                    max: 120,
                    expected: _playingFrameRate
                }
                LogUtil.info(`<${_packageName}>--lottie_ohos request fr: ${_playingFrameRate}`)
                looper.setExpectedFrameRateRange(expectedFrameRate);
            }
        }
    }

    function destroy(animationName) {
        LogUtil.info(`<${_packageName}>--lottie_ohos destroy.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length
        for (let i = (len - 1); i >= 0; i -= 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                //找到即将要被destroy的动画，销毁之。会触发回调，在回调中进行状态清理
                registeredAnimations[i]?.animation.destroy(animationName);
            }
        }
        if (registeredAnimations.length === 0) {
            bez.storedData = {};
        }
    }

    // html only
    function searchAnimations(animationData, standalone, renderer) {
        if (!document) {
            return;
        }
        let animElements = [].concat([].slice.call(document.getElementsByClassName('lottie')),
            [].slice.call(document.getElementsByClassName('bodymovin')));
        let lenAnims = animElements.length;
        for (let i = 0; i < lenAnims; i += 1) {
            if (renderer && !!animElements[i]) {
                animElements[i].setAttribute('data-bm-type', renderer);
            }
            registerAnimation(animElements[i], animationData);
        }
        if (standalone && lenAnims === 0) {
            if (!renderer) {
                renderer = 'svg';
            }
            var body = document.getElementsByTagName('body')[0];
            body.innerText = '';
            var div = createTag('div');
            div.style.width = '100%';
            div.style.height = '100%';
            div.setAttribute('data-bm-type', renderer);
            body.appendChild(div);
            registerAnimation(div, animationData);
        }
    }

    function setContentMode(contentMode) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos setContentMode.${contentMode}`);

        let len = registeredAnimations.length
        for (let i = 0; i < len; i += 1) {
            if (!!registeredAnimations[i]?.animation) {
                registeredAnimations[i]?.animation.setContentMode(contentMode);
            }
        }
    }

    function resize(width, height) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos resize: ${width} x ${height}`);

        let len = registeredAnimations.length
        for (let i = 0; i < len; i += 1) {
            if (!!registeredAnimations[i]?.animation) {
                registeredAnimations[i]?.animation.resize(width, height);
            }
        }
    }

    function getSingletonLooper() {
        if (!!_looper) {
            return _looper;
        }

        _looper = (function(callback){
            var looper = {};
            var _displaySync = null;
            var _animator = null;
            var _DURATION_ = 20000;
            var _monotonicTimeStampInMs = 0;
            var _lastAnimatorProgress = 0;

            function onframe(frameInfo) {
                _monotonicTimeStampInMs = ~~(frameInfo.timestamp / 1000_000); // ns to ms then truncation to integer
                callback(_monotonicTimeStampInMs, true);
            }

            try {
                _displaySync = displaySync.create();
                _displaySync.on("frame", onframe);

                LogUtil.info(`<${_packageName}>--lottie_ohos displaySync created.`);

                looper.first = function () {
                    LogUtil.info(`<${_packageName}>--lottie_ohos displaySync first`);
                }

                looper.start = function () {
                    _displaySync.start();
                }

                looper.stop = function () {
                    _displaySync.stop();
                }

                looper.setExpectedFrameRateRange = function (rateRange) {
                    _displaySync.setExpectedFrameRateRange(rateRange);
                }

                return looper;
            } catch (e) {
                LogUtil.info(`<${_packageName}>--lottie_ohos no displaySync. API level may be too low: ${e.message}`);
                // fallback to animator
            }

            let options = {
                duration: _DURATION_,
                easing: "linear",
                delay: 0,
                fill: "forwards",
                direction: "normal",
                iterations: -1,
                begin: 0,
                end: 1
            };
            _animator = animator.create(options);
            _animator.oncancel = () => {
                _lastAnimatorProgress = 0;
            }
            _animator.onfinish = () => {
                _lastAnimatorProgress = 0;
            }
            _animator.onframe = (progress) => {
                //在每一次帧动画回调时，忽略系统时间，仅以动画步进来计算下一次时间戳，避免时间调整引起的跳变
                _monotonicTimeStampInMs += _DURATION_ * ((progress - _lastAnimatorProgress + 1) % 1);
                _lastAnimatorProgress = progress;
                callback(_monotonicTimeStampInMs, false);
            }

            looper.first = function () {
                _lastAnimatorProgress = 0;
                _monotonicTimeStampInMs = Date.now();
                LogUtil.info(`<${_packageName}>--lottie_ohos animator first: ${_monotonicTimeStampInMs.toFixed(0)}`);
            }

            looper.start = function () {
                _animator.play();
            }

            looper.stop = function () {
                //do not call '_animator.finish' function which will further call onframe causing stack overflow.
                _animator.cancel();
            }

            looper.setExpectedFrameRateRange = function (rateRange) {
                if (_animator.setExpectedFrameRateRange) {
                    _animator.setExpectedFrameRateRange(rateRange);
                } else {
                    LogUtil.info(`<${_packageName}>--lottie_ohos animator no displaySync. API level may be too low.`);
                }
            }

            LogUtil.info(`<${_packageName}>--lottie_ohos animator created.`);

            return looper;
        }(resume));

        return _looper;
    }

    function activate() {
        if (playingAnimationsNum > 0 && _looperStopped) {

            LogUtil.info(`<${_packageName}>--lottie_ohos activate.`);
            getSingletonLooper().first();
            getSingletonLooper().start();

            _looperStopped = false
        }
    }

    function deactivate() {
        if (!_looperStopped) {
            _looperStopped = true;
            LogUtil.info(`<${_packageName}>--lottie_ohos deactivate.`);
            _playingFrameRate = 0;
            getSingletonLooper().stop()
        }
    }

    function freeze() {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos freeze.`);

        deactivate();

        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!!registeredAnimations[i]?.animation) {
                registeredAnimations[i].animation.stop();
            }
        }
    }

    function unfreeze() {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos unfreeze.`);
        let len = registeredAnimations.length;
        for (let i = 0; i < len; i += 1) {
            if (!!registeredAnimations[i]?.animation) {
                registeredAnimations[i].animation.start();
            }
        }

        activate();
    }

    function setVolume(val, animationName) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos setVolume.${val}, ${animationName ? animationName : ""}`);

        let len = registeredAnimations.length
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.setVolume(val, animationName);
            }
        }
    }

    function mute(animationName) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos mute.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.mute(animationName);
            }
        }
    }

    function unmute(animationName) {
        // LogUtil.debug(`<${_packageName}>--lottie_ohos unmute.${animationName ? animationName : ""}`);

        let len = registeredAnimations.length
        for (let i = 0; i < len; i += 1) {
            if (!animationName || registeredAnimations[i]?.animation.name === animationName) {
                registeredAnimations[i]?.animation.unmute(animationName);
            }
        }
    }

    function clearSingleFileCache(path, container) {
        let isHttp = path.startsWith('http');
        if (isHttp) {
            let parts = path.split('/');
            let secondLastSegment = parts[parts.length - 2];
            let lastSegmentWithExtension = parts[parts.length - 1];
            let lastSegment = lastSegmentWithExtension.replace(/\.(zip|json)$/i, '');
            let dirPath = getContext().filesDir + '/lottie';
            let dirPathFirst = `${dirPath}/${secondLastSegment}`;
            dirPath = `${dirPathFirst}/${lastSegment}`;
            rmdir(dirPath);
        }
        if (container) {
            let jsonString = container.getJsonData(path);
            let jsonObj = JSON.parse(jsonString);
            let loadPath = getContext().filesDir + '/lottie/loadImages/';
            let isExitNetworkAssets = jsonObj.assets.some((item) => {
                return item.p && item.p.startsWith('http');
            });
            if (isExitNetworkAssets) {
                rmdir(loadPath, jsonObj);
            }
        }
    }

    function clearFileCache(url, container) {
        const context = getContext();
        if (url) {
            clearSingleFileCache(url, container);
            return;
        }
        let fileDir = context.filesDir + '/lottie';
        let cacheDir = context.cacheDir + '/lottie';
        rmdir(fileDir);
        rmdir(cacheDir);
    }

    function rmAssetsDir(path, assets, filenames) {
        let isHttp = assets.p?.startsWith('http');
        if (isHttp) {
            let index = filenames.indexOf(assets.id + '.png');
            if (index !== -1) {
                fs.unlink(path + filenames[index])
                    .catch((err) => {
                        LogUtil.error(`<${_packageName}>--lottie_ohos remove file failed with error message: ${err.message} , error code: ${err.code}`);
                    });
            }
        }
    }

    function rmDirByPath(path, filename) {
        let dirPath = path + '/' + filename;
        // 判断是否文件夹
        try {
            let isDirectory = fs.statSync(dirPath).isDirectory();
            if (isDirectory) {
                fs.rmdirSync(dirPath);
            } else {
                fs.unlink(dirPath)
                    .catch((err) => {
                        LogUtil.error(`<${_packageName}>--lottie_ohos remove file failed with error message: ${err.message} , error code: ${err.code}`);
                    });
            }
        } catch (err) {
            LogUtil.error('Method rmDirByPath execute error: ' + JSON.stringify(err));
        }
    }

    function rmdir(path, jsonObj) {
        fs.listFile(path).then((filenames) => {
            if (jsonObj) {
                for (let i = 0; i < jsonObj.assets.length; i++) {
                    rmAssetsDir(path, jsonObj.assets[i], filenames);
                }
            } else {
                for (let i = 0; i < filenames.length; i++) {
                    rmDirByPath(path, filenames[i]);
                }
            }
        }).catch((err) => {
            LogUtil.error(`<${_packageName}>--lottie_ohos rmdir ${err.message}`);
        });
    }

    moduleOb.registerAnimation = registerAnimation;
    moduleOb.loadAnimation = loadAnimation;
    moduleOb.setSpeed = setSpeed;
    moduleOb.setDirection = setDirection;
    moduleOb.play = play;
    moduleOb.pause = pause;
    moduleOb.stop = stop;
    moduleOb.togglePause = togglePause;
    moduleOb.searchAnimations = searchAnimations;
    moduleOb.resize = resize;
    moduleOb.clearFileCache = clearFileCache;
    // moduleOb.start = start;
    moduleOb.goToAndStop = goToAndStop;
    moduleOb.destroy = destroy;
    moduleOb.freeze = freeze;
    moduleOb.unfreeze = unfreeze;
    moduleOb.setVolume = setVolume;
    moduleOb.mute = mute;
    moduleOb.unmute = unmute;
    moduleOb.getRegisteredAnimations = getRegisteredAnimations;
    moduleOb.setPackageName = setPackageName;
    moduleOb.setContentMode = setContentMode;
    moduleOb.setMaxFrameRate = setMaxFrameRate;
    return moduleOb;
}());

export default animationManager;
