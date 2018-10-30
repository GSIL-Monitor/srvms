package com.wgb.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class OrderCodeBuilderUtils{

    private static final Lock lock = new ReentrantLock();
    private static final long SLEEP_TIME = 1L;


    private OrderCodeBuilderUtils(){}

    /**
     * 效率有点低
     * private static Double index = 0d;
     * private static String builderOrderCode(String serverCode){
     *  try {
     *      StringBuilder sb;
     *      double flag;
     *       do{
     *           flag = new Random().nextDouble();
     *           index = flag;
     *           sb = new StringBuilder();
     *          Thread.sleep(1L);
     *          SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddSSS");
     *          String code = simpleDateFormat.format(new Date());
     *           sb.append("D").append(serverCode).append("_").append(code);
     *       } while (flag != index);
     *      return sb.toString();
     *   } catch (InterruptedException e) {
     *      e.printStackTrace();
     *   }
     *    return null;
     * }
     **/


      private static String builderOrderCode(String serverCode){
           try {
               lock.lock();
               StringBuilder sb = new StringBuilder();
               Thread.sleep(SLEEP_TIME);
               SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyMMddHHmmssSSS");
               String code = simpleDateFormat.format(new Date());
               sb.append("D").append(serverCode).append("_").append(code);
               return sb.toString();
            } catch (InterruptedException e) {
               e.printStackTrace();
            }finally {
               if(null != lock){
                   lock.unlock();
               }
           }
           return null;
      }



    public static String generationOrderCode(String serverCode){
        return builderOrderCode(serverCode);
    }

    static class TestGenerrationOrderCode implements Runnable{
        public void run() {
            while (true){
                String s = OrderCodeBuilderUtils.generationOrderCode("9002");
                System.out.println(s + " : " + Thread.currentThread().getName());
            }
        }
    }

    /**
     * 测试
     * @param args
     */
    public static void main(String []args){
        ExecutorService executorService = Executors.newFixedThreadPool(10);
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
        executorService.execute(new TestGenerrationOrderCode());
    }
}
