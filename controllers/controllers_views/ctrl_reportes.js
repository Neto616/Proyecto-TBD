const reporte = {
    repo: async(req, res) =>{
        try {
            res.render('reportes')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = reporte