const { bd } = require("../../config/conexion");


const ctrl_juez={
    rtParticiparEvento:async(req,res)=>{
        try {
            const{id}=req.body;
            const usuario=req.session.sesion.numeroControl;
            bd.query('call participar_evento(?,?)',[usuario,id],(error,resultado)=>{
                if(error) return res.json({estatus:'ERR',message:'Ocurrio un error'})
                return res.json({estatus:'OK',message:'Participando'})
            })
        } catch (error) {
            console.log(error)
        }
    },
    rtCalificarEquipo:async(req,res)=>{
        try {
            const{criPro,criDis,criCon,codEqu}=req.body
            console.log(criCon,criPro,criDis)
            const id=req.session.sesion.numeroControl;
            if(codEqu==''){
                return res.json({estatus:'CAMPOS',message:'Falta seleccionar un equipo'})
            }else{
                bd.query(`call calificar_equipo(${criPro},${criDis},${criCon},'${codEqu}','${id}',@mensaje)`,(err,resultado)=>{
                    if(err) console.log(err)
                    bd.query('select @mensaje as mensaje',(err,resultado)=>{
                if(err) console.log(err)
                const mensaje=resultado[0].mensaje
            if(mensaje=='OK'){
                return res.json({estatus:'OK',message:'Calificado'})
            }else{
                return res.json({estatus:'ERR',message:'El equipo no tiene integrantes'})
            }
            })
                })
            }
        } catch (error) {
            console.log(error)
        }
    },
    
}

module.exports=ctrl_juez