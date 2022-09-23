package com.example.frame.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by Administrator on 2021/10/21 0021 10:04
 */
@Slf4j
@Controller
public class IndexController {


    @GetMapping("/login")
    public String login() {
        return "index";
    }



}
