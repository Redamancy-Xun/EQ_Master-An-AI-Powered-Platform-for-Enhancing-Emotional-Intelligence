import CVGaussianBlurEffect from './effects/CVGaussianBlurEffect'

var registeredEffects = {};

function CVEffects(elem) {
    var i;
    var len = elem.data.ef ? elem.data.ef.length : 0;
    this.filters = [];
    var filterManager;
    for (i = 0; i < len; i += 1) {
        filterManager = null;
        var type = elem.data.ef[i].ty;
        //创建高斯模糊效果对象，type为29才是高斯模糊
        if (registeredEffects[type]) {
            filterManager = new CVGaussianBlurEffect(elem.effectsManager.effectElements[i], elem);
        }
        //存储高斯模糊效果对象
        if (filterManager) {
            this.filters.push(filterManager);
        }
    }
    //将高斯模糊效果添加到指定对象
    if (this.filters.length) {
        elem.addRenderableComponent(this);
    }
}

CVEffects.prototype.renderFrame = function (_isFirstFrame) {
    var i;
    var len = this.filters.length;
    for (i = 0; i < len; i += 1) {
        this.filters[i].renderFrame(_isFirstFrame);
    }
};

export function registerCVEffect(id, effect, countsAsEffect) {
    //注册高斯模糊效果监听
    registeredEffects[id] = {
        effect,
        countsAsEffect,
    };
}

export default CVEffects;
