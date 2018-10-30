<@override name="cssfile">
<link href="http://091801.zhonglunnet.com/web/assets/pages/css/error.min.css?version=1.0.0" rel="stylesheet" type="text/css"/>
</@override>
<@override name="content">
<style type="text/css">
    .paysuccess-block-icon {
        width:100%;
        height: 100px;
        float: left;
        padding: 10px 0;
    }
    .paysuccess-block-icon i{
        width: 80px;
        height: 80px;
        display: block;
        margin: auto;
        background-image: url(http://localhost:8088//images/paysuccess.png);
        background-repeat: no-repeat;
        background-size: cover;
    }
    .paysuccess-title{
        width: 100%;
        height: 33px;
        padding: 4px 0;
        float: left;
    }
    .paysuccess-title p{
        margin: 0;
        font-size: 18px;
        font-weight: bold;
        color: #606060;
        letter-spacing: 4px;
        text-align: center;
    }

    .paysuccess-desc{
        width:100%;
        height: 120px;
        float: left;
        text-align: center;
    }

    .paysuccess-desc table{
       width: 100%;
       max-width: 380px;
       margin: auto;
    }    
    .paysuccess-desc td{
        text-align: center;
        padding: 12px 4px;
        white-space: nowrap;
        border-bottom: 1px solid #f1eded;
    }
    .paysuccess-foot{
        width: 100%;
        height: 40px;
        float: left;
    }
    .paysuccess-foot p{
        margin: 0;
        padding: 0;
        width: 100px;
        float: left;
        line-height: 34px;
        margin-right: 0px;
        font-size: 15px;
    }
    .paysuccess-foot-center{
        margin: auto;
        width: 220px;
        height: 40px;
    }
    .paysuccess-foot a {
        display: block;
        float: left;
    }
    #back_count{
        margin: 0;
        padding: 0;
        font-size: 20px;
        color:#BF3333;
    }
    .paysuccess-code{
        text-align: left !important;
        color: #757575;
        font-weight: bold;
        font-size: 18px;
    }
    .paysuccess-money{
        text-align: left !important;
        font-size: 18px;
        font-weight: bold;
        color: #757575;
    }
</style>
<div class="row">
    <div class="col-md-4">
    </div>
     <div class="col-md-4">
        <div class="paysuccess-block">
            <div class="paysuccess-block-icon">
                <i></i>
            </div>
           
            <div class="paysuccess-title">
                <p>
                    支付成功
                </p>
                
            </div>
             <div class="paysuccess-desc">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 30%;">订单编号：</td>
                        <td style="width: 30%;" class="paysuccess-code">${trade_no}</td>
                    </tr>                    
                    <tr>
                        <td style="width: 30%;">支付金额：</td>
                        <td style="width: 30%;" class="paysuccess-money">${total_amount}元</td>
                    </tr>
                </table>
             </div>
             <div class="paysuccess-foot">
                <div class="paysuccess-foot-center">
                    <p style="letter-spacing: 1px;">倒计时<span id="back_count">5</span>秒</p>
                    <a href="http://localhost:8088//index.action" class="btn btn-primary">
                        返回首页
                    </a>
                </div>
             </div>
                
        </div>
    </div>
    <div class="col-md-4">
    </div>
</div>
<script type="text/javascript">  
    $(function() {  
        var count = 5;  
        setInterval(function() {  
            count--;  
            if (count <= 0){
                 window.location.href = "http://localhost:8088//index.action";
            }
            else{
                $("#back_count").html(count);
            }

        }, 1000);   
    });  
</script>
</@override>
<@extends name="./base_error.ftl"/>