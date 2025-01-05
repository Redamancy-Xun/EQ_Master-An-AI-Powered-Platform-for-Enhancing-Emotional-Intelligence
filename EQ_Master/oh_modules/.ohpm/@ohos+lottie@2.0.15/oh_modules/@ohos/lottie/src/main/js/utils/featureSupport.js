const featureSupport = (function () {
  var ob = {
    maskType: true,
    svgLumaHidden: true,
    offscreenCanvas: typeof OffscreenCanvas !== 'undefined',
  };
  return ob;
}());

export default featureSupport;
