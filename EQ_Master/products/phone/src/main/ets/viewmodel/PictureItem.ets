/**
 * Picture entity class.
 */
export class PictureItem {
  id: string = '';
  name: string = '';
  description: string = '';
  image: Resource | undefined = $r('app.media.image1');
}