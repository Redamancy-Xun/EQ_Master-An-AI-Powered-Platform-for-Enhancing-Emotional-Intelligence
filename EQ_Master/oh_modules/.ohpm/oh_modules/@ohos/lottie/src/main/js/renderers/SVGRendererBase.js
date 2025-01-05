import { getLocationHref } from '../main';
import {
  createElementID,
  getExpressionsPlugin,
} from '../utils/common';
import {
  extendPrototype,
} from '../utils/functionExtensions';
import {
  createSizedArray,
} from '../utils/helpers/arrays';
import createNS from '../utils/helpers/svg_elements';
import BaseRenderer from './BaseRenderer';
import IImageElement from '../elements/ImageElement';
import SVGShapeElement from '../elements/svgElements/SVGShapeElement';
import SVGTextLottieElement from '../elements/svgElements/SVGTextElement'; // eslint-disable-line import/no-cycle
import ISolidElement from '../elements/SolidElement';
import NullElement from '../elements/NullElement';

function SVGRendererBase() {
}

extendPrototype([BaseRenderer], SVGRendererBase);

SVGRendererBase.prototype.createNull = function (data) {
  return new NullElement(data, this.globalData, this);
};

SVGRendererBase.prototype.createShape = function (data) {
  return new SVGShapeElement(data, this.globalData, this);
};

SVGRendererBase.prototype.createText = function (data) {
  return new SVGTextLottieElement(data, this.globalData, this);
};

SVGRendererBase.prototype.createImage = function (data) {
  return new IImageElement(data, this.globalData, this);
};

SVGRendererBase.prototype.createSolid = function (data) {
  return new ISolidElement(data, this.globalData, this);
};

SVGRendererBase.prototype.configAnimation = function (animData) {
  this.svgElement.setAttribute('xmlns', 'http://www.w3.org/2000/svg');
  this.svgElement.setAttribute('xmlns:xlink', 'http://www.w3.org/1999/xlink');
  if (this.animationItem.wrapper != undefined) {
    this.canvasContext = this.animationItem.wrapper;
  } else {
    this.canvasContext = this.renderConfig.context;
  }
  if (this.renderConfig.viewBoxSize) {
    this.svgElement.setAttribute('viewBox', this.renderConfig.viewBoxSize);
  } else {
    this.svgElement.setAttribute('viewBox', '0 0 ' + animData.w + ' ' + animData.h);
  }

  if (!this.renderConfig.viewBoxOnly) {
    this.svgElement.setAttribute('width', animData.w);
    this.svgElement.setAttribute('height', animData.h);
    this.svgElement.style.width = '100%';
    this.svgElement.style.height = '100%';
    this.svgElement.style.transform = 'translate3d(0,0,0)';
    this.svgElement.style.contentVisibility = this.renderConfig.contentVisibility;
  }
  if (this.renderConfig.width) {
    this.svgElement.setAttribute('width', this.renderConfig.width);
  }
  if (this.renderConfig.height) {
    this.svgElement.setAttribute('height', this.renderConfig.height);
  }
  if (this.renderConfig.className) {
    this.svgElement.setAttribute('class', this.renderConfig.className);
  }
  if (this.renderConfig.id) {
    this.svgElement.setAttribute('id', this.renderConfig.id);
  }
  if (this.renderConfig.focusable !== undefined) {
    this.svgElement.setAttribute('focusable', this.renderConfig.focusable);
  }
  this.svgElement.setAttribute('preserveAspectRatio', this.renderConfig.preserveAspectRatio);
  // this.layerElement.style.transform = 'translate3d(0,0,0)';
  // this.layerElement.style.transformOrigin = this.layerElement.style.mozTransformOrigin = this.layerElement.style.webkitTransformOrigin = this.layerElement.style['-webkit-transform'] = "0px 0px 0px";
  // this.animationItem.wrapper.appendChild(this.svgElement);
  // Mask animation
  var defs = this.globalData.defs;

  this.setupGlobalData(animData, defs);
  this.globalData.progressiveLoad = this.renderConfig.progressiveLoad;
  this.data = animData;

  var maskElement = createNS('clipPath');
  var rect = createNS('rect');
  rect.setAttribute('width', animData.w);
  rect.setAttribute('height', animData.h);
  rect.setAttribute('x', 0);
  rect.setAttribute('y', 0);
  var maskId = createElementID();
  maskElement.setAttribute('id', maskId);
  maskElement.appendChild(rect);
  this.layerElement.setAttribute('clip-path', 'url(' + getLocationHref() + '#' + maskId + ')');

  defs.appendChild(maskElement);
  this.layers = animData.layers;
  this.elements = createSizedArray(animData.layers.length);
};

SVGRendererBase.prototype.destroy = function () {
  if (this.canvasContext) {
    this.canvasContext.clearRect(0, 0, this.canvasContext.width, this.canvasContext.height)
  }
  this.layerElement = null;
  this.globalData.defs = null;
  var i;
  var len = this.layers ? this.layers.length : 0;
  for (i = 0; i < len; i += 1) {
    if (this.elements[i]) {
      this.elements[i].destroy();
    }
  }
  this.elements.length = 0;
  this.destroyed = true;
  this.animationItem = null;
};

SVGRendererBase.prototype.updateContainerSize = function () {
};

SVGRendererBase.prototype.updateContentMode = function (contentMode) {
};

SVGRendererBase.prototype.findIndexByInd = function (ind) {
  var i = 0;
  var len = this.layers.length;
  for (i = 0; i < len; i += 1) {
    if (this.layers[i].ind === ind) {
      return i;
    }
  }
  return -1;
};

SVGRendererBase.prototype.buildItem = function (pos) {
  var elements = this.elements;
  if (elements[pos] || this.layers[pos].ty === 99) {
    return;
  }
  elements[pos] = true;
  var element = this.createItem(this.layers[pos]);

  elements[pos] = element;
  if (getExpressionsPlugin()) {
    if (this.layers[pos].ty === 0) {
      this.globalData.projectInterface.registerComposition(element);
    }
    element.initExpressions();
  }
  this.appendElementInPos(element, pos);
  if (this.layers[pos].tt) {
    var elementIndex = ('tp' in this.layers[pos])
      ? this.findIndexByInd(this.layers[pos].tp)
      : pos - 1;
    if (elementIndex === -1) {
      return;
    }
    if (!this.elements[elementIndex] || this.elements[elementIndex] === true) {
      this.buildItem(elementIndex);
      this.addPendingElement(element);
    } else {
      var matteElement = elements[elementIndex];
      var matteMask = matteElement.getMatte(this.layers[pos].tt);
      element.setMatte(matteMask);
    }
  }
};

SVGRendererBase.prototype.checkPendingElements = function () {
  while (this.pendingElements.length) {
    var element = this.pendingElements.pop();
    element.checkParenting();
    if (element.data.tt) {
      var i = 0;
      var len = this.elements.length;
      while (i < len) {
        if (this.elements[i] === element) {
          var elementIndex = 'tp' in element.data
            ? this.findIndexByInd(element.data.tp)
            : i - 1;
          var matteElement = this.elements[elementIndex];
          var matteMask = matteElement.getMatte(this.layers[i].tt);
          element.setMatte(matteMask);
          break;
        }
        i += 1;
      }
    }
  }
};

SVGRendererBase.prototype.changeColor = function (color, endColor, layer, index) {
  if (typeof endColor == 'object') {
    if (Array.isArray(endColor)) {
      if (!layer) {
        var len = this.layers.length;
        var i;
        for (i = 0; i < len; i += 1) {
          let tag = true;
          if (this.layers[i] && this.layers[i].td) {
            tag = false;
          }
          if (tag && (this.completeLayers || this.elements[i])) {
            this.elements[i].changeColor(color, endColor);
          }
        }
      } else {
        if (this.completeLayers || this.elements[layer-1]) {
          this.elements[layer-1].changeColor(color, endColor, index);
        }
      }
    }
  } else if (typeof endColor == 'number') {
    if (endColor == 0) {
      var len = this.layers.length;
      var i;
      for (i = 0; i < len; i += 1) {
        let tag = true;
        if (this.layers[i] && this.layers[i].td) {
          tag = false;
        }
        if (tag && (this.completeLayers || this.elements[i])) {
          this.elements[i].changeColor(color, undefined);
        }
      }
    } else {
      if (this.completeLayers || this.elements[endColor-1]) {
        this.elements[endColor-1].changeColor(color, endColor, layer);
      }
    }
  } else {
    var len = this.layers.length;
    var i;
    for (i = 0; i < len; i += 1) {
      let tag = true;
      if (this.layers[i] && this.layers[i].td) {
        tag = false;
      }
      if (tag && (this.completeLayers || this.elements[i])) {
        this.elements[i].changeColor(color, undefined);
      }
    }
  }
}

SVGRendererBase.prototype.renderFrame = function (num,tag) {
  if(tag){
    this.renderedFrame  =-1;
  }
  if (this.renderedFrame === num || this.destroyed) {
    return;
  }
  if (num === null) {
    num = this.renderedFrame;
  } else {
    this.renderedFrame = num;
  }
  // console.log('-------');
  // console.log('FRAME ',num);
  this.globalData.frameNum = num;
  this.globalData.frameId += 1;
  this.globalData.projectInterface.currentFrame = num;
  this.globalData._mdf = false;
  var i;
  var len = this.layers.length;
  if (!this.completeLayers) {
    this.checkLayers(num);
  }
  for (i = len - 1; i >= 0; i -= 1) {
    if (this.completeLayers || this.elements[i]) {
      this.elements[i].prepareFrame(num - this.layers[i].st);
    }
  }
  if (this.globalData._mdf) {
    for (i = 0; i < len; i += 1) {
      if (this.completeLayers || this.elements[i]) {
        this.elements[i].renderFrame();
      }
    }
  }
  let width = this.canvasContext.width
  let height = this.canvasContext.height

  this.startX = 0
  this.startY = 0
  if (width > height) {
    this.dp = width / this.svgElement['ks']['width']
    if (height > this.svgElement['ks']['height'] * this.dp) {
      this.dp = width / this.svgElement['ks']['width']
      this.startY = (height - this.svgElement['ks']['height'] * this.dp) / 2

    } else {
      this.dp = height / this.svgElement['ks']['height']
      this.startX = (width - this.svgElement['ks']['width'] * this.dp) / 2

    }
  } else {
    this.dp = height / this.svgElement['ks']['height']
    if (width > this.svgElement['ks']['width'] * this.dp) {
      this.dp = height / this.svgElement['ks']['height']
      this.startX = (width - this.svgElement['ks']['width'] * this.dp) / 2
    } else {
      this.dp = width / this.svgElement['ks']['width']
      this.startY = (height - this.svgElement['ks']['height'] * this.dp) / 2
    }
  }
  //清空上一帧
  this.canvasContext.clearRect(0, 0, width, height)
  //渲染动画 this.svgElement为svg标签封装实体
  this.renderLabel(this.svgElement)
};

/*
    * @param path   path元素
    * @param color  传递色值
    * @param op     传递透明度
    * @param isMask 是否为mask子元素
    * */
SVGRendererBase.prototype.renderPath = function (path, color, op=-1, isMask=false) {
  let props = Object.keys(path['ks']);
  if (props.indexOf('d') > -1) {
    let d = path['ks']['d'];
    let spaces = d.split(' ');
    let xys = []
    var ft = ''
    var ed = ''
    var begins = false
    for (let i = 0;i < spaces.length; i++) {
      if (spaces[i] != '') {
        let item = spaces[i]
        let first = spaces[i].charAt(0)
        let end = spaces[i].substr(-1)
        let xy = []
        if (first == 'M' || first == 'L' || first == 'H' || first == 'V' || first == 'C' || first == 'S' || first == 'Q' || first == 'T' || first == 'A') {
          ft = first
          xys = []
          xy = spaces[i].split(',')
          xy[0] = xy[0].slice(1)

        } else {
          xy = item.split(',')
        }
        if (end == 'z' || end == 'Z') {
          xy[1] = xy[1].slice(0, -1)
          ed = 'z'
        }
        xys.push(xy)
        if (ft == 'M' && xys.length == 1) {
          if (!begins) {
            this.canvasContext.beginPath()
            begins = !begins
          }
          let x = Number(xys[0][0]) * this.dp
          let y = Number(xys[0][1]) * this.dp
          this.canvasContext.moveTo(x, y)
          //moveto(M X,Y) ：将画笔移动到指定的坐标位置
        } else if (ft == 'L' && xys.length == 1) {
          let x = Number(xys[0][0]) * this.dp
          let y = Number(xys[0][1]) * this.dp
          this.canvasContext.lineTo(x, y)
          //lineto(L X,Y) ：画直线到指定的坐标位置
        } else if (ft == 'H') {
          //horizontal lineto(H X)：画水平线到指定的X坐标位置
        } else if (ft == 'V') {
          break; //vertical lineto(V Y)：画垂直线到指定的Y坐标位置
        } else if (ft == 'C' && xys.length == 3) {
          let x1 = Number(xys[0][0]) * this.dp
          let y1 = Number(xys[0][1]) * this.dp
          let x2 = Number(xys[1][0]) * this.dp
          let y2 = Number(xys[1][1]) * this.dp
          let x3 = Number(xys[2][0]) * this.dp
          let y3 = Number(xys[2][1]) * this.dp
          this.canvasContext.bezierCurveTo(x1, y1, x2, y2, x3, y3)
          //curveto(C X1,Y1,X2,Y2,ENDX,ENDY)：三次贝赛曲线
        } else if (ft == 'S') {
          //smooth curveto(S X2,Y2,ENDX,ENDY)
        } else if (ft == 'Q' && xys.length == 2) {
          let x1 = Number(xys[0][0]) * this.dp
          let y1 = Number(xys[0][1]) * this.dp
          let x2 = Number(xys[1][0]) * this.dp
          let y2 = Number(xys[1][1]) * this.dp
          this.canvasContext.quadraticCurveTo(x1, y1, x2, y2)
          //quadratic Belzier curve(Q X,Y,ENDX,ENDY)：二次贝赛曲线
        } else if (ft == 'T') {
          //smooth quadratic Belzier curveto(T ENDX,ENDY)：映射
        } else if (ft == 'A') {

        } //elliptical Arc(A RX,RY,XROTATION,FLAG1,FLAG2,X,Y)：弧线
        if (ed == 'z') {
          this.canvasContext.closePath()
          ed = ''
        }
      }
    }
  }


  if (props.indexOf('stroke-linecap') > -1) {
    this.canvasContext.lineCap = path['ks']['stroke-linecap']
  }
  if (props.indexOf('stroke-linejoin') > -1) {
    this.canvasContext.lineJoin = path['ks']['stroke-linejoin']
  }
  if (props.indexOf('stroke-miterlimit') > -1) {
    this.canvasContext.miterLimit = path['ks']['stroke-miterlimit']
  }
  if (props.indexOf('stroke-dasharray') > -1) {
    this.canvasContext.setLineDash(path['ks']['stroke-dasharray'])
  }
  if (props.indexOf('stroke-dashoffset') > -1) {
    this.canvasContext.lineDashOffset = path['ks']['stroke-dashoffset']
  }


  if (props.indexOf('stroke-width') > -1) {
    this.canvasContext.lineWidth = path['ks']['stroke-width'] * this.dp
  }
  if (props.indexOf('stroke') > -1) {
    this.canvasContext.strokeStyle = path['ks']['stroke']
    this.canvasContext.stroke()
  }
  if (op != -1) {
    this.canvasContext.globalAlpha = op
  }

  if (props.indexOf('fill') > -1) {
    let cl = ''
    if (path['ks']['fill'].indexOf('url(#') > -1) {
      let id = path['ks']['fill']
      id = id.substring(0, id.length - 1);
      id = id.slice(5)
      for (let i = 0;i < this.defs.length; i++) {
        if (this.defs[i]['ks']['id'] == id) {
          this.renderLabel(this.defs[i], color, isMask)
        }
      }
    } else {

      if (path['ks']['fill'] == '#ffffff') { //mask中白色为可见,正常处理传入色值
        if (color != undefined) {
          cl = color
        }
        if (isMask) { //mask目前用clip实现简单效果
          this.canvasContext.clip()
        }
      } else {
        if (isMask) {
          if (path['ks']['fill'] == '#000000' || path['ks']['fill'] == 'rgb(0,0,0)') {
            //mask中黑色为不可见
            this.canvasContext.globalAlpha = 0
          } else {
            cl = color
            this.canvasContext.clip()
          }
        } else {
          cl = path['ks']['fill']
        }

      }
      if (props.indexOf('fill-opacity') > -1) {
        let op = Number(path['ks']['fill-opacity'])
        if (cl != undefined && op != undefined) {
          this.canvasContext.fillStyle = this.colorOpt(cl, op)
        }
      } else {
        this.canvasContext.fillStyle = cl
      }
      if (props.indexOf('clip-rule') > -1) {
        this.canvasContext.fill(path['ks']['clip-rule'])
      } else {
        this.canvasContext.fill()
      }
    }
  } else if (color != undefined) {
    this.canvasContext.fillStyle = color
    this.canvasContext.fill()
  }


}

/**
 * 十六进制颜色值转为带透明度的颜色
 * @param thisColor 十六进制颜色
 * @param thisOpacity 透明度
 * @returns {string} rgba
 */
SVGRendererBase.prototype.colorOpt = function (thisColor, thisOpacity) {
  var theColor = thisColor.toLowerCase();
  //十六进制颜色值的正则表达式
  var r = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
  // 如果是16进制颜色
  if (theColor && r.test(theColor)) {

    if (theColor.length === 4) {
      var sColorNew = '#';
      for (var i = 1; i < 4; i += 1) {
        sColorNew += theColor.slice(i, i + 1).concat(theColor.slice(i, i + 1));
      }
      theColor = sColorNew;
    }
    //处理六位的颜色值
    var sColorChange = [];
    for (var j = 1; j < 7; j += 2) {
      sColorChange.push(parseInt('0x' + theColor.slice(j, j + 2)));
    }
    return 'rgba(' + sColorChange.join(',') + ',' + thisOpacity + ')';
  }
  // 如果是rgba或者rgb
  if (theColor.startsWith('rgb')) {
    let numbers = theColor.match(/(\d(\.\d+)?)+/g);
    numbers = numbers.slice(0, 3).concat(thisOpacity);
    return 'rgba(' + numbers.join(',') + ')';
  }

  return theColor;
}

/**
 * 根据id查询全局defs中的元素并渲染
 * @param clipId 元素ID
 * @param svg    当前元素
 * @param color  传递色值
 * */
SVGRendererBase.prototype.renderClipPath = function (clipId, svg, color) {
  clipId = clipId.substring(0, clipId.length - 1);
  clipId = clipId.slice(5)
  let isRender = true
  let j = 0

  while (isRender) {
    if (this.defs[j]['ks']['id'] == clipId) {
      let cl
      if (svg['childs'].length > 0) {
        for (let i = 0;i < svg['childs'].length; i++) {
          //判断是否有色值可以传递
          let rectp = Object.keys(svg['childs'][i]['ks']);
          if (svg['childs'][i]['label'] == 'rect' && rectp.indexOf('fill')) {
            cl = svg['childs'][i]['ks']['fill']
          }
        }
      }
      if (cl != undefined) {
        this.renderLabel(this.defs[j], cl)
      } else {
        this.renderLabel(this.defs[j], color)
      }
      isRender = false
    }
    j++
  }
}
/**
 * 渲染svg标签
 * @param svg     label实体
 * @param color   传递色值
 * @param opacity 传递透明度
 * @param isMask  判断是否为Mask,并传递
 * */
SVGRendererBase.prototype.renderLabel = function (svg, color, opacity=-1, isMask=false) {
  //标签名
  let labelName = svg['label']
  //标签实体属性名集合
  let props = Object.keys(svg['ks']);
  //标签实体style集合
  let styles = Object.keys(svg['style']);
  //是否显示
  let isDis = false
  switch (labelName) {
    case 'svg':
      this.canvasContext.fillStyle = '#00000000' //不设置填充色,默认渲染rect为黑色，这里设置为透明色
      this.canvasContext.fillRect(this.startX, this.startY, Number(svg['ks']['width']) * this.dp, Number(svg['ks']['height']) * this.dp)
      if (labelName != 'defs' && svg['childs'] != undefined && !isDis) {
        for (let i = 0;i < svg['childs'].length; i++) {
          this.renderLabel(svg['childs'][i])
        }
      }
      break;
    case 'clipPath':
      for (let r = 0;r < svg['childs'].length; r++) {
        if (color != undefined) {
          this.renderLabel(svg['childs'][r], color)
        } else {
          this.renderLabel(svg['childs'][r])
          this.canvasContext.clip()
        }
      }
      break
    case 'radialGradient':
      if (props.indexOf('cx') > -1 && props.indexOf('cy') > -1 && props.indexOf('r') > -1 && props.indexOf('fx') > -1 && props.indexOf('fy') > -1) {
        var x0 = Number(svg['ks']['cx']) * this.dp
        var y0 = Number(svg['ks']['cy']) * this.dp
        var r = Number(svg['ks']['r']) * this.dp
        var x1 = Number(svg['ks']['fx']) * this.dp
        var y1 = Number(svg['ks']['fy']) * this.dp
        var grad = this.canvasContext.createRadialGradient(x1, y1, 0, x0, y0, r)
        for (let i = 0;i < svg['childs'].length; i++) {
          let item = svg['childs'][i]
          let op = item['ks']['offset']
          if (op.indexOf('%') > -1) {
            op = Number(op.replace('%', ''))
          }
          grad.addColorStop(op / 100, item['ks']['stop-color'])
        }
        this.canvasContext.fillStyle = grad
        this.canvasContext.fill()
      }
      break
    case 'linearGradient':
      if (props.indexOf('x1') > -1 && props.indexOf('y1') > -1 && props.indexOf('x2') > -1 && props.indexOf('y2') > -1) {
        var x0 = Number(svg['ks']['x1']) * this.dp
        var y0 = Number(svg['ks']['y1']) * this.dp
        var x1 = Number(svg['ks']['x2']) * this.dp
        var y1 = Number(svg['ks']['y2']) * this.dp
        var grad = this.canvasContext.createLinearGradient(x0, y0, x1, y1)
        for (let i = 0;i < svg['childs'].length; i++) {
          let item = svg['childs'][i]
          let op = item['ks']['offset']
          if (op.indexOf('%') > -1) {
            op = Number(op.replace('%', ''))
          }
          grad.addColorStop(op / 100, item['ks']['stop-color'])
        }
        this.canvasContext.fillStyle = grad
        this.canvasContext.fill()
      }
      break;
    case 'symbol':
      for (let i = 0;i < svg['childs'].length; i++) {
        this.renderLabel(svg['childs'][i], color, opacity, isMask)
      }
      break;
    case 'use':
      if (props.indexOf('href') > -1) {
        let useId = svg['ks']['href']
        useId = useId.slice(1)
        //根据id在全局defs中查询并渲染
        for (let i = 0;i < this.defs.length; i++) {
          if (this.defs[i]['ks']['id'] == useId) {
            this.renderLabel(this.defs[i], color, opacity, isMask)
          }
        }
      }
      for (let i = 0;i < svg['childs'].length; i++) {
        this.renderLabel(svg['childs'][i], color, opacity, isMask)
      }
      break;
    case 'filter':
      break;
    case 'defs':
    //将defs数据赋值给全局
      this.defs = svg['childs']
      break;
    case 'rect':
      this.canvasContext.rect(this.startX, this.startY, Number(svg['ks']['width']) * this.dp, Number(svg['ks']['height']) * this.dp)
      break
    case 'path':
    //color和isMask是从mask子元素传来的
      this.renderPath(svg, color, opacity, isMask)
      break;
    case 'mask':
      for (let i = 0;i < svg['childs'].length; i++) {
        //向子元素传递color和isMask
        this.renderLabel(svg['childs'][i], color, opacity, true)
      }
      break;
    case 'g':
      if (styles.length > 0) {
        for (let k = 0;k < styles.length; k++) {
          if (styles[k] == 'display') {
            if (svg['style'][styles[k]] == 'none') {
              isDis = true //隐藏
            }
            if (svg['style'][styles[k]] == 'block') {
              isDis = false //显示
            }
          }
        }
      }
      if (props.length > 0 && !isDis) {
        if (props.indexOf('transform') > -1) {
          if (svg['ks']['transform'].indexOf('matrix') > -1) {
            let mat = svg['ks']['transform']
            mat = mat.substring(0, mat.length - 1);
            mat = mat.slice(7)
            let numbers = mat.split(',')
            if (svg['childs'].length > 0) {
              this.matrix.push(numbers)
              this.cLength.push(svg['childs'].length)
            }
            for (let j = 0;j < this.matrix.length; j++) {
              let mx = this.matrix[j]
              //setTransform执行会重置matrix,所以第一条以外都用transform
              if (j == 0) {
                this.canvasContext.setTransform(Number(mx[0]), Number(mx[1]), Number(mx[2]), Number(mx[3]), (Number(mx[4]) * this.dp) + this.startX, (Number(mx[5]) * this.dp) + this.startY)
              } else {
                this.canvasContext.transform(Number(mx[0]), Number(mx[1]), Number(mx[2]), Number(mx[3]), (Number(mx[4]) * this.dp), (Number(mx[5]) * this.dp))
              }
            }
          }
          if (svg['ks']['transform'].indexOf('translate') > -1) {
            let tlt = svg['ks']['transform']
            tlt = tlt.substring(0, tlt.length - 1);
            tlt = tlt.slice(9)
            let xy = tlt.split(',')
            this.canvasContext.translate(Number(xy[0]), Number(xy[1]))
          }
          if (svg['ks']['transform'].indexOf('scale') > -1) {
            let scale = svg['ks']['transform']
            scale = scale.substring(0, scale.length - 1);
            scale = scale.slice(5)
            let xy = scale.split(',')
            this.canvasContext.scale(Number(xy[0]), Number(xy[1]))
          }
        }
        if (props.indexOf('opacity') > -1) {
          if (Number(svg['ks']['opacity']) != 1) {
            opacity = svg['ks']['opacity']
          } else {
            this.canvasContext.globalAlpha = svg['ks']['opacity']
          }
        }
        if (props.indexOf('fill') > -1) {
          color = svg['ks']['fill']
        }
        if (props.indexOf('clip-path') > -1) {
          let clipPathId = svg['ks']['clip-path']
          var isClip = false
          let count = 0
          for (let i = 0;i < svg['childs'].length; i++) {
            let it = svg['childs'][i]
            let pp = Object.keys(it['ks']);
            if (pp.indexOf('aria-label') > -1) {
              count++
              if (i == svg['childs'].length - 1) {
                isClip = (count == svg['childs'].length)
              }
            }
          }
          if (!isClip) {
            this.renderClipPath(clipPathId, svg)
          }
        }
        if (props.indexOf('mask') > -1) {
          let maskId = svg['ks']['mask']
          this.renderClipPath(maskId, svg)
        }
        if (props.indexOf('filter') > -1) {
          let filterId = svg['ks']['filter']
          this.renderClipPath(filterId, svg)
        }
      }
      if (labelName != 'defs' && svg['childs'].length > 0 && !isDis) {
        //渲染子元素,并清除当前元素的matrix
        for (let n = 0;n < svg['childs'].length; n++) {
          this.canvasContext.save()
          let rect = Object.keys(svg['childs'][n]['ks']);
          if (props.indexOf('clip-path') < 0 && props.indexOf('mask') < 0 && props.indexOf('filter') < 0 && svg['childs'][n]['label'] == 'rect' && rect.indexOf('fill') > -1) {
            this.canvasContext.fillStyle = svg['childs'][n]['ks']['fill']
            this.canvasContext.fillRect(0, 0, Number(svg['childs'][n]['ks']['width']) * this.dp, Number(svg['childs'][n]['ks']['height']) * this.dp)
          } else {
            //向子元素传递color和isMask
            this.renderLabel(svg['childs'][n], color, opacity, isMask)
            let k = this.matrix.length - 1
            if (k != undefined && n == this.cLength[k] - 1) {
              this.matrix.splice(-1)
              this.cLength.splice(-1)
            }
          }
          this.canvasContext.restore()
        }
      }
      break;
  }
}

SVGRendererBase.prototype.appendElementInPos = function (element, pos) {
  var newElement = element.getBaseElement();
  if (!newElement) {
    return;
  }
  var i = 0;
  var nextElement;
  while (i < pos) {
    if (this.elements[i] && this.elements[i] !== true && this.elements[i].getBaseElement()) {
      nextElement = this.elements[i].getBaseElement();
    }
    i += 1;
  }
  if (nextElement) {
    this.layerElement.insertBefore(newElement, nextElement);
  } else {
    this.layerElement.appendChild(newElement);
  }
};

SVGRendererBase.prototype.hide = function () {
  this.layerElement.style.display = 'none';
};

SVGRendererBase.prototype.show = function () {
  this.layerElement.style.display = 'block';
};

export default SVGRendererBase;
