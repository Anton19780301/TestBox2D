#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <box2dplugin.h>

#include <QImage>
#include <QDebug>
#include "gamecontroller.hpp"



int main( int argc, char* argv[] )
{
  QCoreApplication::setAttribute( Qt::AA_EnableHighDpiScaling );
  QGuiApplication app( argc, argv );
  Box2DPlugin plugin;
  plugin.registerTypes( "Box2DStatic" );

  QQmlApplicationEngine engine;
  auto* rootContext = engine.rootContext();
  GameController gameController;

  rootContext->setContextProperty( "GameController", &gameController );
  engine.addImageProvider( "puzzleImage", gameController.getImageProvider() );

  const QUrl url( QStringLiteral( "qrc:/main.qml" ) );
  QObject::connect( &engine, &QQmlApplicationEngine::objectCreated,
  &app, [url]( QObject * obj, const QUrl & objUrl ) {
    if ( !obj && url == objUrl ) {
      QCoreApplication::exit( -1 );
    }
  }, Qt::QueuedConnection );
  engine.load( url );

  return app.exec();
}


/*

The coefficient of restitution is a number which indicates how much kinetic energy (energy of motion) remains after a collision of two objects. If the coefficient is high (very close to 1.00) it means that very little kinetic energy was lost during the collision.

The coefficient of friction (COF), often symbolized by the Greek letter µ, is a dimensionless scalar value which describes the ratio of the force of friction between two bodies and the force pressing them together. The coefficient of friction depends on the materials used; for example, ice on steel has a low coefficient of friction, while rubber on pavement has a high coefficient of friction.

For a pure substance the density has the same numerical value as its mass concentration.



 * */
