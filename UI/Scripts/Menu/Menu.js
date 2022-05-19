var contador = 1;
var varCerrarSesion = 1;

$(document).ready(menuCerrarSesion);
$(document).ready(main);

function main() {
    $('.btn_menu').click(function () {
        var ancho = screen.width * 0.25;

        if (contador == 1) {
            if (screen.width < 800) {
                $('.wrapper').animate({
                    left: '0',
                    width: '70%'
                });
                $('.Contenido').animate({
                    marginLeft: '70%',
                    marginRight: '10'
                });
                $('.divMenu_cerrar').animate({
                    right: '-100%'
                });
            }
            else {
                $('.wrapper').animate({
                    left: '0',
                    width: ancho
                });
                $('.Contenido').animate({
                    marginLeft: ancho + 2,
                    marginRight: '10'
                });
                $('.divMenu_cerrar').animate({
                    right: '-100%'
                });
            }
            $('.navicon-line').css("background-color", "rgb(38, 152, 219)");
            $('.img_CerrarSession').attr('src', '../Imagenes/Menu/Cerrar_Sesion.png');
            contador = 0;

        } else {
            contador = 1;
            $('.wrapper').animate({
                left: '-100%'
            });
            $('.Contenido').animate({
                marginLeft: '0'
            });
            $('.navicon-line').css("background-color", "white");

        }
    })
}

function menuCerrarSesion() {

    $('.LN_CerrarSesion').click(function () {
        if (varCerrarSesion == 1) {
            $('.divMenu_cerrar').animate({
                right: '0'
            });

            $('.wrapper').animate({
                left: '-100%'
            });

            $('.Contenido').animate({
                marginLeft: '0'
            });
            $('.navicon-line').css("background-color", "white");
            $('.img_CerrarSession').attr('src', '../Imagenes/Menu/Cerrar_Sesion_Hover.png');
            varCerrarSesion = 0;

        } else {
            varCerrarSesion = 1;
            $('.img_CerrarSession').attr('src', '../Imagenes/Menu/Cerrar_Sesion.png');
            $('.divMenu_cerrar').animate({
                right: '-100%'
            });
        }
    })
}