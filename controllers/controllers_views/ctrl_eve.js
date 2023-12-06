const ev = {
    eve: async(req, res) =>{
        try {
            res.render('ins-evento')
        } catch (error) {
            console.log(error);
        }
    }
}

module.exports = ev