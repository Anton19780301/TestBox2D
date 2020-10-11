#pragma once

#include <QQuickImageProvider>
#include <memory>
class QVariant;


class ImageProvider : public QQuickImageProvider
{
public:
  ImageProvider( );
  QImage requestImage( const QString& id, QSize* size, const QSize& requestedSize ) override;

  void setWindowDimenions( int windowWidth, int windowHeight ) ;
  int puzzlePieceCount( ) ;

  int imageWidth() const { return mImageWidth ;}
  int imageHeight() const { return mImageHeight;}

  int imagePieceWidth() const { return mImagePieceWidth ;}
  int imagePieceHeight() const { return mImagePieceHeight;}

  bool isPuzzleSolved( QVariantList xCoordinatesList, QVariantList yCoordinatesList ) const;

  void loadNextImage();

private:
  const QString image0{":/images/tile0.jpg"};
  const QString image1{":/images/tile1.jpg"};

  double mDevicePixelRatio;
  const int mColumnRowCount{2};

  QString mImagePath{ image0};

  QImage mImage;

  int mWindowWidth{0};
  int mWindowHeight{0};

  double mImageWidth{0};
  double mImageHeight{0};

  double mImagePieceWidth{0};
  double mImagePieceHeight{0};

  double mPieceXPosition{0};
  double mPieceYPosition{0};



};


