function CVGaussianBlurEffect(filterManager, elem) {
    this.filterManager = filterManager;
    this.canvasContext = elem.canvasContext;
}

CVGaussianBlurEffect.prototype.renderFrame = function (forceRender) {
    //获取图层高斯模糊值
    var sigma = this.filterManager.effectElements[0].p.v;
    //给图层设置高斯模糊效果
    this.canvasContext.filter = 'blur(' + sigma + 'px)';

};

export default CVGaussianBlurEffect;
