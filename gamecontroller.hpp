#pragma once


#include <QObject>
#include "imageprovider.hpp"


class GameController final : public QObject
{
  Q_OBJECT
public:
  explicit GameController( QObject* parent = nullptr );
  ImageProvider* getImageProvider() {return &mImageProvider;}

  Q_INVOKABLE void setWindowDimenions( int windowWidth, int windowHeight ) {mImageProvider.setWindowDimenions( windowWidth, windowHeight );}
  Q_INVOKABLE int puzzlePieceCount()  {return mImageProvider.puzzlePieceCount(); }
  Q_INVOKABLE int imageWidth() const {return mImageProvider.imageWidth() ;}
  Q_INVOKABLE int imageHeight() const {return mImageProvider.imageHeight() ;}

  Q_INVOKABLE int imagePieceWidth() const { return mImageProvider.imagePieceWidth() ;}
  Q_INVOKABLE int imagePieceHeight() const { return mImageProvider.imagePieceHeight();}

  Q_INVOKABLE bool isPuzzleSolved( QVariantList xCoordinatesList, QVariantList yCoordinatesList ) const;
  Q_INVOKABLE void loadNextImage() ;

signals:
  void displayImage();


private:
//  ImageProvider mImageProvider{3, ":/images/wallpaper.png"};
// ImageProvider mImageProvider{3, ":/images/testImage.png"};
  ImageProvider mImageProvider;

};


