@Component
export struct StandardIcon {
  @Prop icon: Resource;

  build() {
    Image(this.icon)
      .width($r('app.float.icon_height_one'))
      .height($r('app.float.icon_width_one'))
  }
}