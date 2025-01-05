import lottie from './canvas_light';
import {
  setExpressionsPlugin,
  setExpressionInterfaces,
} from '../utils/common';
import Expressions from '../utils/expressions/Expressions';
import interfacesProvider from '../utils/expressions/InterfacesProvider';
import expressionPropertyDecorator from '../utils/expressions/ExpressionPropertyDecorator';
import expressionTextPropertyDecorator from '../utils/expressions/ExpressionTextPropertyDecorator';

// Canvas effects
import { registerCVEffect } from '../elements/canvasElements/CVEffects';
import CVGaussianBlurEffect from '../elements/canvasElements/effects/CVGaussianBlurEffect';

// Registering expression plugin
setExpressionsPlugin(Expressions);
setExpressionInterfaces(interfacesProvider);
expressionPropertyDecorator();
expressionTextPropertyDecorator();

// Registering canvas effects
registerCVEffect(29, CVGaussianBlurEffect, true);

export default lottie;
