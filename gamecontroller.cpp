#include "gamecontroller.hpp"
#include <QDebug>
#include <QList>

GameController::GameController( QObject* parent ) : QObject( parent )
{

}

bool GameController::isPuzzleSolved( QVariantList xCoordinatesList, QVariantList yCoordinatesList ) const
{
  return mImageProvider.isPuzzleSolved ( xCoordinatesList, yCoordinatesList );
}

void GameController::loadNextImage()
{
  qDebug() << Q_FUNC_INFO << "+++++++++++++";
  mImageProvider.loadNextImage();
  emit displayImage();
}
