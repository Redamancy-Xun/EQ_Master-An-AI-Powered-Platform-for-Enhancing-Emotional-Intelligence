import assetManager from '../../utils/helpers/assetManager';
import getBlendMode from '../../utils/helpers/blendModes';
import Matrix from '../../3rd_party/transformation-matrix';
import CVEffects from './CVEffects';
import CVMaskElement from './CVMaskElement';

function CVBaseElement() {
}

var operationsMap = {
  1: 'destination-in',
  2: 'destination-out',
  3: 'destination-in',
  4: 'destination-out',
};

CVBaseElement.prototype = {
  createElements: function () {},
  initRendererElement: function () {},
  createContainerElements: function () {
    // If the layer is masked we will use two buffers to store each different states of the drawing
    // This solution is not ideal for several reason. But unfortunately, because of the recursive
    // nature of the render tree, it's the only simple way to make sure one inner mask doesn't override an outer mask.
    // TODO: try to reduce the size of these buffers to the size of the composition containing the layer
    // It might be challenging because the layer most likely is transformed in some way
    this.canvasContext = this.globalData.canvasContext;
    this.transformCanvas = this.globalData.transformCanvas;
    this.renderableEffectsManager = new CVEffects(this);
  },
  createContent: function () {},
  setBlendMode: function () {
    var globalData = this.globalData;
    if (globalData.blendMode !== this.data.bm) {
      globalData.blendMode = this.data.bm;
      var blendModeValue = getBlendMode(this.data.bm);
      globalData.canvasContext.globalCompositeOperation = blendModeValue;
    }
  },
  createRenderableComponents: function () {
    this.maskManager = new CVMaskElement(this.data, this);
  },
  hideElement: function () {
    if (!this.hidden && (!this.isInRange || this.isTransparent)) {
      this.hidden = true;
    }
  },
  showElement: function () {
    if (this.isInRange && !this.isTransparent) {
      this.hidden = false;
      this._isFirstFrame = true;
      this.maskManager._isFirstFrame = true;
    }
  },
  clearCanvas: function (canvasContext) {
    canvasContext.clearRect(
      this.transformCanvas.tx,
      this.transformCanvas.ty,
      this.transformCanvas.w * this.transformCanvas.sx,
      this.transformCanvas.h * this.transformCanvas.sy
    );
  },
  prepareLayer: function () {
    if (this.data.tt >= 1) {
      if (!this.canvasContext.saveLayer) {
        return;
      }
      this.canvasContext.globalCompositeOperation = 'source-over';
      this.canvasContext.saveLayer();
      //保存递归图层
      this.canvasContext.saveLayer();
      //对之前的混合模式还原成默认模式
      this.canvasContext.globalCompositeOperation = 'source-over';

    }
  },
  exitLayer: function () {
    if (this.data.tt >= 1) {
      if (!this.canvasContext.saveLayer || !this.canvasContext.restoreLayer) {
        return;
      }
      //恢复图层
      this.canvasContext.restoreLayer();
      //将递归图层和mask动效图层进行指定混合
      this.canvasContext.globalCompositeOperation = operationsMap[this.data.tt];
      //保存mask动效层
      this.canvasContext.saveLayer();
      //对之前的混合模式还原成默认模式
      this.canvasContext.globalCompositeOperation = 'source-over';
      // We draw the mask
      const mask = this.comp.getElementById('tp' in this.data ? this.data.tp : this.data.ind - 1);
      mask?.renderFrame(true);
      //恢复图层
      this.canvasContext.restoreLayer();
      this.canvasContext.restoreLayer();
      this.canvasContext.globalCompositeOperation = 'source-over';
    }
  },
  renderFrame: function (forceRender) {
    if (this.hidden || this.data.hd) {
      return;
    }
    if (this.data.td === 1 && !forceRender) {
      return;
    }
    this.renderTransform && this.renderTransform();
    this.renderRenderable && this.renderRenderable();
    this.setBlendMode();
    var forceRealStack = this.data.ty === 0;
    //开始处理mask数据：包含两层layer数据，需要创建两个离屏绘制上下文
    this.prepareLayer();
    this.globalData.renderer.save(forceRealStack);
    this.globalData.renderer.ctxTransform(this.finalTransform.mat.props);
    this.globalData.renderer.ctxOpacity(this.finalTransform.mProp.o.v);
    this.renderInnerContent && this.renderInnerContent();
    this.globalData.renderer.restore(forceRealStack);
    //将两个layer数据分别绘制到两个离屏画布上，通过将离屏绘制数据结合混合模式绘制到当前显示画布上，实现mask效果
    this.exitLayer();

    //恢复高斯模糊的默认值，防止非高斯模糊图层也高斯模糊
    this.canvasContext.filter = 'blur(0px)'

    if (this.maskManager.hasMasks) {
      this.globalData.renderer.restore(true);
    }
    if (this._isFirstFrame) {
      this._isFirstFrame = false;
    }
  },
  changeColor: function (color, endColor, index) {
    this._isFirstFrame = true;
    this.renderShapeColor && this.renderShapeColor(color, endColor, index);
  },
  destroy: function () {
    this.canvasContext = null;
    this.data = null;
    this.globalData = null;
    this.maskManager.destroy();
  },
  mHelper: new Matrix(),
};
CVBaseElement.prototype.hide = CVBaseElement.prototype.hideElement;
CVBaseElement.prototype.show = CVBaseElement.prototype.showElement;

export default CVBaseElement;
