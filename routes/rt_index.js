const { Router } = require('express')
const router = Router()


router.use(require('./rt_routes'));

router.use(require('./rt_views'));



module.exports = router;