import { svgNS } from '../../main';

function createNS(types) {
  return new createNs(types, svgNS)
}

function createNs(types, svg) {
  this.label = types
  this.ks = {}
  this.childs = new Array()
  this.style = {}
  if (types == 'svg' && svg != null)
    this.setAttribute("xmlns", svg)
}

createNs.prototype.setAttributeNS = function (n, k, v) {
  this.setAttribute("xmlns", n)
  this.ks[k+''] = v
}

createNs.prototype.setAttribute = function (k, v) {
  this.ks[k+''] = v
}

createNs.prototype.appendChild = function (element) {
  if (element != undefined)
    this.childs.push(element)
}

createNs.prototype.insertBefore = function (newNode, referenceNode) {
  let addindex = this.childs.indexOf(referenceNode)
  this.childs.splice(addindex, 0, newNode)
}

export default createNS;
