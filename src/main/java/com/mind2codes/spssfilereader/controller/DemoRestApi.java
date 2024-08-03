package com.mind2codes.spssfilereader.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("api/v1/customers")
public class DemoRestApi {

    @GetMapping
    public ResponseEntity<Map<String, Object>> getAll() {
        Map<String, Object> map = new HashMap<>();
        map.put("message", "Merci pour votre contribution!!!");
        map.put("status", true);
        return new ResponseEntity<>(map, HttpStatus.OK);
    }
}
