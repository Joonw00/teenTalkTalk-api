var login_service = require("../../services/login-service");

exports.SignIn = async function(req, res) {
  try{
    const result = await login_service.SignIn(req);
    if (result.code == 0) {
      res.cookie('userid', result.data.userid);
      res.cookie('username', result.data.user_name, {
        maxAge: 60 * 60 * 1000, // 만료 시간
        path: "/" // 쿠키가 전송될 경로
      });
      req.session.user = result;
    }
    return result;
  } catch(error) {
    console.log('login-controller SignIn:'+error);
  }
};


// 회원가입 컨트롤러
exports.signUp = async function(req, res) {
  try{
    var result = await login_service.signUp(req);
    return result;
  } catch(error) {
    console.log('login-controller login_check:'+error);
  }
};

exports.getAttendance = async function(req, res) {
  try{
    var result = await login_service.getAttendance(req);
    return result;
  } catch(error) {
    console.log('login-controller getAttendance:'+error);
  }
};

exports.checkAttendance = async function(req, res) {
  try{
    var result = await login_service.checkAttendance(req);
    return result;
  } catch(error) {
    console.log('login-controller checkAttendance:'+error);
  }
};