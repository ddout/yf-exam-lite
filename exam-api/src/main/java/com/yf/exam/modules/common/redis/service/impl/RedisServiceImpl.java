package com.yf.exam.modules.common.redis.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.yf.exam.core.utils.StringUtils;
import com.yf.exam.modules.common.redis.service.RedisService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.concurrent.TimeUnit;

/**
 * @author bool
 */
@Service
public class RedisServiceImpl implements RedisService {

    /**
     * 锁相关内容
     */
    private static final String lock = "locked";

    @Autowired
    private RedisTemplate<String, String> redisTemplate;

    /**
     * 删除一个或多个缓存
     * @param key
     */
    @Override
    public void del(String... key) {
        if (key != null && key.length > 0) {
            if (key.length == 1) {
                redisTemplate.delete(key[0]);
            } else {
                redisTemplate.delete(CollectionUtils.arrayToList(key));
            }
        }
    }

    @Override
    public JSONObject getJson(String key) {
        String json = this.get(key);

        if(!StringUtils.isBlank(json)){
            return JSON.parseObject(json);
        }

        return null;
    }

    @Override
    public String getString(String key) {
        return get(key);
    }


    /**
     * 获得一个锁
     *
     * @param key
     * @return
     */
    @Override
    public boolean tryLock(String key, Long ms) {
        // 获得一个50毫秒的锁
        return redisTemplate.opsForValue().setIfAbsent(key, lock, ms, TimeUnit.MILLISECONDS);
    }

    /**
     * 获取缓存内容
     *
     * @param key
     * @return
     */
    public String get(String key) {
        return redisTemplate.opsForValue().get(key);
    }


    /**
     * 设置缓存值
     *
     * @param key
     * @param data
     * @return
     */
    @Override
    public boolean set(String key, String data) {
        try {
            redisTemplate.opsForValue().set(key, data);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    /**
     * 设置缓存
     *
     * @param key
     * @param value
     * @param time
     * @return
     */
    @Override
    public boolean set(String key, String value, Long time) {
        try {
            if (time > 0) {
                redisTemplate.opsForValue().set(key, value, time, TimeUnit.SECONDS);
            } else {
                this.set(key, value);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
