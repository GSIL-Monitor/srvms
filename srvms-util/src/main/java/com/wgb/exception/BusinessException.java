//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package com.wgb.exception;

import com.wgb.exception.AbstractServiceException;
import com.zl.bean.ExceptionBean;

public class BusinessException extends AbstractServiceException {
    public BusinessException(String errorCode) {
        super(errorCode);
    }

    public BusinessException(ExceptionBean exceptionBean){
        super(exceptionBean);
    }

    /**
     * 抛异常方式
     * @param args
     */
    public static void main(String[] args) {
        throw new BusinessException("biz.addmember.phonenum.exist");
    }

    /**
     * 系统内置了默认异常如下：
     AddException("sys.error.network.failure", "system error", "系统异常！");
     AddException("com.error.session.timeout", "session timeout", "抱歉，您无权进行该操作，请先登录！");
     AddException("com.error.without.privilege", "session timeout", "抱歉，您没有访问该功能的权限！");
     AddException("com.error.opera.error", "opera error", "操作异常！");
     AddException("com.error.opera.timeout", "opera timeout", "操作过期，请刷新后重试！");
     AddException("com.error.param.missing", "param missing", "参数缺失！");
     AddException("com.error.param.error", "param error", "参数错误！");
     AddException("com.error.del.required", "del required", "系统内置数据,无法删除！");
     AddException("com.error.del.update.required", "del or update required", "系统内置数据,无法编辑或删除！");
     AddException("com.error.export.empty", "export empty", "请选择要导出的数据！");
     AddException("com.error.yzm.send.interval.short", "yzm send interval too short", "手机验证码发送过于频繁，请您稍后再试");
     AddException 方法参数：1、异常编码 2、英文描述 3、中文描述
     **/

    static {
        AddException("biz.addmember.phonenum.exist", "add member fail,phone num already exist", "新建会员失败，输入的手机号已经存在！");
        AddException("biz.dubbo.system", "invoke dubbo system error", "调用dubbo系统异常");
        AddException("biz.system.err", "process exception", "操作异常，请联系管理员!");
    }
}
