// 选中Text中文字后可以查询ai

function createCustomMenuItems(menuItems: Array<TextMenuItem>): Array<TextMenuItem> {
  const item1: TextMenuItem = {
    content: '询问AI情商助手',
    id: TextMenuItemId.of('QUERY'),
  };
  menuItems.push(item1);
  return menuItems;
}

function handleMenuItemClick(menuItem: TextMenuItem, textRange: TextRange): boolean {
  if (menuItem.id.equals(TextMenuItemId.of("QUERY"))) {
    console.log("拦截 QUERY start:" + textRange.start + "; end:" + textRange.end);
    return true;
  }
  if (menuItem.id.equals(TextMenuItemId.COPY)) {
    console.log("不拦截 COPY start:" + textRange.start + "; end:" + textRange.end);
    return false;
  }
  if (menuItem.id.equals(TextMenuItemId.SELECT_ALL)) {
    console.log("不拦截 SELECT_ALL start:" + textRange.start + "; end:" + textRange.end);
    return false;
  }
  return false;
}

//外部仅需调用此处
//使用方法如下
// Text(this.text)
//   .fontSize(20)
//   .copyOption(CopyOptions.LocalDevice)
//   .editMenuOptions(this.editMenuOptions)
//   .margin({ top: 100 })
export const CustomEditMenuOptions: EditMenuOptions = {
  onCreateMenu: createCustomMenuItems,
  onMenuItemClick: handleMenuItemClick
};



// 以下是用例，可预览查看
@Entry
@Component
struct TextExample12 {
  @State text: string = 'Text editMenuOptions'
  onCreateMenu = (menuItems: Array<TextMenuItem>) => {
    let item1: TextMenuItem = {
      content: '询问AI情商助手',
      id: TextMenuItemId.of('QUERY'),
    };
    menuItems.push(item1);
    return menuItems;
  }
  onMenuItemClick = (menuItem: TextMenuItem, textRange: TextRange) => {
    if (menuItem.id.equals(TextMenuItemId.of("QUERY"))) {
      console.log("拦截 QUERY start:" + textRange.start + "; end:" + textRange.end);
      return true;
    }
    if (menuItem.id.equals(TextMenuItemId.COPY)) {
      console.log("不拦截 COPY start:" + textRange.start + "; end:" + textRange.end);
      return false;
    }
    if (menuItem.id.equals(TextMenuItemId.SELECT_ALL)) {
      console.log("不拦截 SELECT_ALL start:" + textRange.start + "; end:" + textRange.end);
      return false;
    }
    return false;
  };
  @State editMenuOptions: EditMenuOptions = {
    onCreateMenu: this.onCreateMenu, onMenuItemClick: this.onMenuItemClick
  };

  build() {
    Column() {
      Text(this.text)
        .fontSize(20)
        .copyOption(CopyOptions.LocalDevice)
        .editMenuOptions(this.editMenuOptions)
        .margin({ top: 100 })
    }
    .width("90%")
    .margin("5%")
  }
}