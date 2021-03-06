USE [PORTAL]
GO
/****** Object:  StoredProcedure [dbo].[PORTAL_OC_APROBAR]    Script Date: 09/23/2020 23:17:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PORTAL_OC_APROBAR] (@PCia varchar(max), @PORDEN_COMPRA VARCHAR(40), @PUSUARIO VARCHAR(40), @PError int, @PMerr varchar(4000))


as

begin

declare @obtiene_estado as NVARCHAR(MAX) 
declare @obtiene_proveedor as NVARCHAR(MAX)
declare @obtiene_EAM as NVARCHAR(MAX)
declare @obtiene_CA as NVARCHAR(MAX)
declare @obtiene_estado_Exactus as NVARCHAR(MAX)
declare @PEstadoOC as varchar(1)
declare @PProveedor as varchar(20)
declare @PU_OCEAM as varchar(20)
declare @PEstadoExactus as varchar(20)
declare @PU_carta_aceptacion as varchar(40)
declare @TIENEPERMISOAPROBAR as varchar(4);
declare @PPresupuesto_CR as varchar(20)
declare @PTotal_Mercaderia as decimal(28,8)

declare @PFecha as datetime
declare @PDepartamento as varchar(10)
declare @ReglaMontoDep as varchar(1);
declare @ReglaMontoUsr as varchar(1);
declare @PermisoPresupuesto as varchar(1);
declare @obtiene_datos as Nvarchar(MAX);
Declare @PDTipo_Cambio as varchar(20);
Declare @VLinea as int;
Declare @VCENTRO_COSTO as varchar(40);
Declare @VPARTIDA as varchar(40);
declare @VTOTAL as decimal(28,8)

declare @VDISPONIBLE as decimal(28,8)


Declare @VNumero as int;

DECLARE @BasedeDatos as varchar(40);
Set @BasedeDatos  = 'ME';

Declare @UserID varchar(100)
Declare @ORDEN_LINEA table([ORDEN_COMPRA] [varchar](10) NOT NULL,
	[CENTRO_COSTO] [varchar](25) NULL,
    [PARTIDA] [varchar](50) NULL,
	[TOTAL] [decimal](28, 8) NULL,
	[DISPONIBLE] [decimal](28, 8) NULL);



   --SELECT [CENTRO_COSTO], sum([CANTIDAD_ORDENADA]*[PRECIO_UNITARIO]) TOTAL  FROM [ME].[cromsa].[ORDEN_COMPRA_LINEA] WHERE orden_compra = 'OC009159'  GROUP BY [CENTRO_COSTO]

  /*SELECT @TIENEPERMISOAPROBAR = 'S'
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUSUARIO or ('PortalRep' = REPLACE(@PUSUARIO, CHAR(10), ''))) and 
  P.[ACTIVO] = 'S' and P.conjunto = c.conjunto and
  P.accion = 1345 AND P.[CONJUNTO] = @PCia1;*/
  
  set @TIENEPERMISOAPROBAR = 'N';
  SELECT @TIENEPERMISOAPROBAR = 'S'
  FROM [ME].[erpadmin].[PRIVILEGIO_EX] P, me.erpadmin.conjunto C
  where (P.usuario = @PUSUARIO or ('PortalRep' = REPLACE(@PUSUARIO, CHAR(10), ''))) and 
  P.[ACTIVO] = 'S' and P.conjunto = c.conjunto and
  P.accion = 1345 AND P.[CONJUNTO] = @PCia;
  
  if (@TIENEPERMISOAPROBAR = 'S')
    begin
       set @obtiene_estado = N'select @PEstadoOC = estado, @PPresupuesto_CR = presupuesto_cr, @PTotal_Mercaderia = Total_Mercaderia, @PFecha = fecha, @PDepartamento = Departamento 
         from me.' + cast(@PCia as varchar(20)) + '.orden_compra where orden_compra = ''' + @PORDEN_COMPRA + ''''
       EXEC SP_EXECUTESQL  @obtiene_estado, N'@PEstadoOC as varchar(1) output, @PPresupuesto_CR as varchar(20) output, @PTotal_Mercaderia as decimal(28,8) output, @PFecha as datetime output, @PDepartamento as varchar(10) output', 
                           @PEstadoOC  = @PEstadoOC OUTPUT, 
                           @PPresupuesto_CR = @PPresupuesto_CR OUTPUT, 
                           @PTotal_Mercaderia = @PTotal_Mercaderia OUTPUT, 
                           @PFecha = @PFecha OUTPUT,
                           @PDepartamento = @PDepartamento output
                           

       if (@PEstadoOC = 'P')
          begin
            set @obtiene_estado = N'select @ReglaMontoDep = ''S''  from me.' + cast(@PCia as varchar(20)) + '.[RANGOS_AUTORIZA_DEP] where [MONTO_MAX_COMPRA] >= ' + cast(@PTotal_Mercaderia as varchar(200)) + ' and [DEPARTAMENTO] =  ''' + @PDepartamento + ''''
            EXEC SP_EXECUTESQL  @obtiene_estado, N'@ReglaMontoDep as varchar (1) output', @ReglaMontoDep  = @ReglaMontoDep OUTPUT
            
          
            set @obtiene_estado = N'select @ReglaMontoUsr = ''S''  from me.' + cast(@PCia as varchar(20)) + '.[USUARIOS_DEPARTAMENTO] where [MONTO_MAX_APROB_USR] >= ' + cast(@PTotal_Mercaderia as varchar(200)) + ' and [USUARIO] =  ''' + @PUSUARIO + ''''
            EXEC SP_EXECUTESQL  @obtiene_estado, N'@ReglaMontoUsr as varchar (1) output', @ReglaMontoUsr  = @ReglaMontoUsr OUTPUT
          

            if (@ReglaMontoDep = 'S' and  @ReglaMontoUsr = 'S')
              Begin        
                
                -- Busco si el usuario tiene permiso sobre el presupuesto
                
                   set @PermisoPresupuesto = 'N';
                   Set @obtiene_estado = N'select @PermisoPresupuesto = ''S''  SELECT PRIV_EJECUCION  FROM [ME].[cromsa].[USUARIO_PRESUP]  WHERE presupuesto = ''' + @PPresupuesto_CR + ''' and [USUARIO] =  ''' + @PUSUARIO + ''''
                   EXEC SP_EXECUTESQL  @obtiene_estado, N'@PermisoPresupuesto as varchar (1) output', @PermisoPresupuesto  = @PermisoPresupuesto OUTPUT

                   if @PermisoPresupuesto = 'S' 
                     Begin
                       -- Verifica el disponible
                       --   ************************  FALTA AQUI VERIFICAR SI TIENE DISPONIBLE    ************************************
                         
                         
                         
                          
                   
                        -- Busco la partida, el valor disponible y el total en dolares   
                
                
                   

                   
                   
                
                          -- Busco la tasa de cambio
                             Set @obtiene_datos = 'SELECT @PDTipo_Cambio = [TIPO_CAMBIO] FROM [ME].' + @PCia + '.[GLOBALES_CO]';
                             EXEC SP_EXECUTESQL  @obtiene_datos, N'@PDTipo_Cambio varchar(50) OUTPUT', @PDTipo_Cambio = @PDTipo_Cambio OUTPUT;
                    
                    
                            set @obtiene_estado = N'SELECT O.ORDEN_COMPRA, [CENTRO_COSTO], (SELECT PARTIDA FROM ME.' + @PCIA + '.DETALLE_PRESUP P WHERE P.presupuesto = ''' + @PPresupuesto_CR + ''' AND P.CENTRO_COSTO = L.[CENTRO_COSTO] AND CONVERT(CHAR(6),PERIODO,112) = CONVERT(CHAR(6),GETDATE(),112)) PARTIDA,
                                case o.moneda when ''USD'' then sum(l.[CANTIDAD_ORDENADA]*l.[PRECIO_UNITARIO])  else ((sum(l.[CANTIDAD_ORDENADA]*l.[PRECIO_UNITARIO])) / (SELECT top(1) [MONTO] FROM [ME].cromsa.[TIPO_CAMBIO_HIST] H 
                                Where h.tipo_cambio = ''' + @PDTipo_Cambio + ''' and  h.fecha = (select max(K.fecha) from [ME].' + @PCIA + '.[TIPO_CAMBIO_HIST] K where K.tipo_cambio = ''' + @PDTipo_Cambio + ''' and k.fecha <= O.fecha)) ) End TOTAL,
                               (SELECT SUM(MONTO_LOCAL) + SUM(REDUCCION_LOCAL) - SUM(COMPR_LOCAL)- SUM(EJEDEV_LOCAL) FROM ME.' + @PCIA + '.DETALLE_PRESUP P WHERE P.PRESUPUESTO = ''' + @PPresupuesto_CR + ''' AND P.CENTRO_COSTO = L.[CENTRO_COSTO] ) DISPONIBLE
                                FROM [ME].' + @PCIA + '.[ORDEN_COMPRA_LINEA] L, [ME].' + @PCIA + '.[ORDEN_COMPRA] O WHERE O.orden_compra = L.orden_compra and O.orden_compra = ''' + @PORDEN_COMPRA + '''
                                GROUP BY O.ORDEN_COMPRA, [CENTRO_COSTO], o.FECHA, o.moneda';
                     
                     
                               Insert into @ORDEN_LINEA ([ORDEN_COMPRA],[CENTRO_COSTO],[PARTIDA],[TOTAL],[DISPONIBLE])
                               Exec(@obtiene_estado);                     




                       
                       
                              Insert into [cromsa].[ENC_MOV_APLICADO] ([UNIDAD_OPERATIVA],[NUMERO],[FECHA],[PRESUPUESTO],[TRANSACCION],[ESTADO],[AFECTACION_DOBLE],[REQUIERE_FONDOS],[MODULO_ORIGEN],[MOV_CONTABLE],[COMENTARIO],[MOV_INICIAL], [NOTAS],[TRASPASO])
                              VALUES ('IEA',23545, GETDATE(),	@PPresupuesto_CR,	'N',	'N',	'N',	'CO',	NULL, 'Movimiento de apartado generado por compra de mercadería',	'N',	'Asiento de apartado para un presupuesto liberado. Movimiento de apartado generado por compra de mercadería',	'S');

                              Set @VLinea = 1;


                              Declare COrden_linea cursor for Select [CENTRO_COSTO],[PARTIDA],[TOTAL],[DISPONIBLE] from @ORDEN_LINEA
                              OPEN COrden_linea
                              FETCH NEXT FROM COrden_linea
                              INTO @VCENTRO_COSTO,@VPARTIDA,@VTOTAL,@VDISPONIBLE

                              WHILE @@FETCH_STATUS = 0
                                BEGIN
                                  Set @obtiene_estado = N'update ME.CROMSA.DETALLE_PRESUP SET COMPR_LOCAL = ISNULL(COMPR_LOCAL,0) + ' + @VTOTAL + ' WHERE PRESUPUESTO =  ''' + @PPresupuesto_CR + ''' AND PARTIDA = ''' + @VPARTIDA + ''' AND CONVERT(CHAR(6),PERIODO, 112) = convert(char(6), GETDATE(), 112)  and centro_costo = ''' + @VCENTRO_COSTO + ''''
                                  EXEC SP_EXECUTESQL  @obtiene_estado

                                  Insert [ME].[cromsa].[DET_MOV_APLICADO] ([UNIDAD_OPERATIVA],[NUMERO],[LINEA], [PRESUPUESTO],[CENTRO_COSTO],[PARTIDA],[FECHA],[PERIODO],[TRANSACCION],[MONTO_LOCAL],[UNIDADES],[UND_OPER_AFECTADA],[CONTRAPARTIDA])
                                  Values ('IEA', @VNumero, @VLinea, @PPresupuesto_CR, @VCENTRO_COSTO, @VPARTIDA, getdate(), getdate(),40, @VTOTAL, 0, 'IEA', 'N');
                         
                                  Set @VLinea = @VLinea + 1;

                                 FETCH NEXT FROM COrden_linea
                                INTO @VCENTRO_COSTO,@VPARTIDA,@VTOTAL,@VDISPONIBLE
                              END
                              CLOSE COrden_linea
                              DEALLOCATE COrden_linea
  
                              EXECUTE AS USER = @PUSUARIO;
                              set @obtiene_estado = N'UPDATE me.' + cast(@PCia as varchar(20)) + '.orden_compra SET estado = ''E'' where orden_compra = ''' + @PORDEN_COMPRA + ''''
                              EXEC SP_EXECUTESQL  @obtiene_estado
             

                              set @obtiene_estado = N'insert into me.' + cast(@PCia as varchar(20)) + '.[USUARIOS_APROB_OC] ([ORDEN_COMPRA],[USUARIO],[FECHA_APROB])
                                  values (''' + @PORDEN_COMPRA + ''', ''' + @PUSUARIO + ''', GETDATE())';
                              EXEC SP_EXECUTESQL  @obtiene_estado
                  
                             SET @PMerr = 'Se cambió el estado a Aprobada.';
                             Set @PError = 0;
                      End;      
                          
               end;
             else
               begin
                   SET @PMerr = 'El Monto autorizado para el usuario es menor que el permitido.';
                   Set @PError = 4;
               End;
             
          End;
        else
          begin
            set @PError = 1;
            set @PMerr = 'La Orden no se encuentra Por Aprobar.';
          end;
     End
   else
     Begin
       set @PError = 2;
       set @PMerr = 'No tiene permiso para aprobar la orden.';
     end;
     
end ;












