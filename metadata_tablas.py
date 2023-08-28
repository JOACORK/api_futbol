# Import Librerías 
from sqlalchemy import create_engine, func, MetaData, Table,String, Column, DateTime, Integer, Date, Boolean, ForeignKey, UniqueConstraint
from sqlalchemy.orm import sessionmaker


def creacion_meta_data(usuario,password,schema):
    # Establecer la conexión con la base de datos
    engine = create_engine(f'mysql://{usuario}:{password}@localhost/{schema}')

    # Crear una sesión para interactuar con la base de datos
    Session = sessionmaker(bind=engine)
    session = Session()

    # Definir el modelo para la tabla MiTabla
    metadata = MetaData()
    return(session, metadata)
    

def creacion_tablas_metadata(metadata):
    # Definir la tabla 'paises'
    paises = Table('paises', metadata,
        Column('codigo', String(2), primary_key=True),
        Column('pais', String(100)),
        extend_existing=True  
    )

    # Definir la tabla 'ligas'
    ligas = Table('ligas', metadata,
        Column('id', Integer, primary_key=True),
        Column('codigo_pais', String(2), ForeignKey('paises.codigo')),
        Column('nombre_liga', String(100)),
        Column('tipo_liga', String(45)),
        extend_existing=True  
    )

    # Definir la tabla 'datos_ligas'
    datos_ligas = Table('datos_ligas', metadata,
        Column('liga_id', Integer, ForeignKey('ligas.id'), primary_key=True),
        Column('temporada', Integer, primary_key=True),
        Column('inicio', Date),
        Column('fin', Date),
        Column('f_eventos', Boolean),
        Column('f_alineaciones', Boolean),
        Column('f_estadisticas', Boolean),
        Column('f_jugadores', Boolean),
        Column('clasificaciones', Boolean),
        Column('jugadores', Boolean),
        Column('top_goleadores', Boolean),
        Column('top_asistencias', Boolean),
        Column('top_tarjetas', Boolean),
        Column('lesiones', Boolean),
        Column('predicciones', Boolean),
        Column('apuestas', Boolean),
        extend_existing=True  
        # Agrega las demás columnas aquí
    )

    # Definir la tabla 'equipos'
    equipos = Table('equipos', metadata,
        Column('id', Integer, primary_key=True),
        Column('nombre', String(100)),
        Column('codigo', String(3)),
        Column('fundado', Integer),
        Column('id_liga', Integer, ForeignKey('ligas.id')),
        extend_existing=True  
    )

       # Definir la tabla 'ligas_equipos'
    ligas_equipos = Table('ligas_equipos', metadata,
        Column('id_liga', Integer, ForeignKey('ligas.id')),
        Column('id_equipo', Integer, ForeignKey('ligas.id')),
        Column('temporada', Integer),
        Column('nombre_equipo', String(50)),
        extend_existing=True  
    )


    # Definir la tabla 'equipos_estadisticas'
    equipos_estadisticas = Table('equipos_estadisticas', metadata,
        Column('id', Integer, primary_key=True, autoincrement=True),
        Column('id_equipo', Integer, nullable=True),
        Column('id_liga', Integer, nullable=True),
        Column('temporada', Integer, nullable=True),
        Column('pj_local', Integer, nullable=True),
        Column('pj_visitante', Integer, nullable=True),
        Column('pg_local', Integer, nullable=True),
        Column('pg_visitante', Integer, nullable=True),
        Column('pe_local', Integer, nullable=True),
        Column('pe_visitante', Integer, nullable=True),
        Column('pp_local', Integer, nullable=True),
        Column('pp_visitante', Integer, nullable=True),
        Column('goles_local', Integer, nullable=True),
        Column('goles_visitante', Integer, nullable=True),
        Column('goles_contra_local', Integer, nullable=True),
        Column('goles_contra_visitante', Integer, nullable=True),
        Column('arco_invicto_local', Integer, nullable=True),
        Column('arco_invicto_visitante', Integer, nullable=True),
        Column('goles_errados_local', Integer, nullable=True),
        Column('goles_errados_visitante', Integer, nullable=True),
        Column('penales_convertidos', Integer, nullable=True),
        Column('penales_errados', Integer, nullable=True),
        Column('actualizacion', DateTime , server_default= func.now(), on_update= func.now()),
        UniqueConstraint('id_equipo','id_liga','temporada'),
        extend_existing=True  
        # Agrega las demás columnas aquí
    )

    # Definir la tabla 'tarjetas_detalles'
    tarjetas_detalles = Table('tarjetas_detalles', metadata,
        Column('id_equipo', Integer, primary_key=True),
        Column('a_0_15', Integer, nullable=True),
        Column('a_16_30', Integer, nullable=True),
        Column('a_31_45', Integer, nullable=True),
        Column('a_46_60', Integer, nullable=True),
        Column('a_61_75', Integer, nullable=True),
        Column('a_76_90', Integer, nullable=True),
        Column('a_91_105', Integer, nullable=True),
        Column('a_106_120', Integer, nullable=True),
        Column('r_0_15', Integer, nullable=True),
        Column('r_16_30', Integer, nullable=True),
        Column('r_31_45', Integer, nullable=True),
        Column('r_46_60', Integer, nullable=True),
        Column('r_61_75', Integer, nullable=True),
        Column('r_76_90', Integer, nullable=True),
        Column('r_91_105', Integer, nullable=True),
        Column('r_106_120', Integer, nullable=True),
        extend_existing=True  
    )

    # Definir la tabla 'goles_detalles'
    goles_detalles = Table('goles_detalles', metadata,
        Column('id_equipo', Integer, primary_key=True),
        Column('gf_0_15', Integer),
        Column('gf_16_30', Integer),
        Column('gf_31_45', Integer),
        Column('gf_46_60', Integer),
        Column('gf_61_75', Integer),
        Column('gf_76_90', Integer),
        Column('gf_91_105', Integer),
        Column('gf_106_120', Integer),
        Column('gc_0_15', Integer),
        Column('gc_16_30', Integer),
        Column('gc_31_45', Integer),
        Column('gc_46_60', Integer),
        Column('gc_61_75', Integer),
        Column('gc_76_90', Integer),
        Column('gc_91_105', Integer),
        Column('gc_106_120', Integer),
        extend_existing=True  
        )

    # Definir la tabla 'hitos_equipos'
    hitos_equipos = Table('hitos_equipos', metadata,
        Column('id_equipo_estadistica', Integer, primary_key=True),
        Column('mayor_racha_victorias', Integer),
        Column('mayor_racha_empates', Integer),
        Column('mayor_racha_derrotas', Integer),
        Column('mayor_victoria_local', String(6)),
        Column('mayor_victoria_visitante', String(6)),
        Column('mayor_derrota_local', String(6)),
        Column('mayor_derrota_visitante', String(6)),
        Column('mayor_goles_convertidos_local', Integer),
        Column('mayor_goles_convertidos_visitante', Integer),
        Column('mayor_goles_recibidos_local', Integer),
        Column('mayor_goles_recibidos_visitante', Integer),
        extend_existing=True  
    )

    # Definir la tabla 'formaciones_equipos'
    formaciones_equipos = Table('formaciones_equipos', metadata,
        Column('id_equipo_estadistica', Integer, primary_key=True),
        Column('formacion', String(45)),
        Column('partidos', Integer),
        extend_existing=True  
    )
    return (paises, ligas, datos_ligas, equipos, ligas_equipos, equipos_estadisticas, tarjetas_detalles, goles_detalles, hitos_equipos, formaciones_equipos)

