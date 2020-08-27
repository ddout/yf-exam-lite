package com.yf.exam.modules.common.redis.service;

import com.alibaba.fastjson.JSONObject;

/**
 * Redis公共服务
 * @author bool 
 */
public interface RedisService {

    /**
     * 获得一个锁
     * @param key
     * @param ms 锁入毫秒数
     * @return
     */
    boolean tryLock(String key, Long ms);

    /**
     * 删除缓存key
     * @param keys
     */
    void del(String ... keys);

    /**
     * 获取缓存内容
     * @param key
     * @return
     */
    JSONObject getJson(String key);

    /**
     * 获取缓存内容
     * @param key
     * @return
     */
    String getString(String key);


    /**
     * 设置缓存值
     * @param key
     * @param data
     * @return
     */
    boolean set(String key,  String data);

    /**
     * 设置缓存
     * @param key
     * @param value
     * @param time
     * @return
     */
    boolean set(String key, String value, Long time);

}
