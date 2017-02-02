#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "fluid/core/iconsimageprovider.h"
#include "fluid/controls/iconthemeimageprovider.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImageProvider(QLatin1String("fluidicons"), new IconsImageProvider());
    engine.addImageProvider(QLatin1String("fluidicontheme"), new IconThemeImageProvider());
    engine.addImportPath(QStringLiteral("qrc:/"));
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
