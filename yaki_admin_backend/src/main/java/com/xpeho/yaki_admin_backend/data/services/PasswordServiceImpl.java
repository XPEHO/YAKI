package com.xpeho.yaki_admin_backend.data.services;

import org.apache.commons.text.RandomStringGenerator;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PasswordServiceImpl {

    public String generatePassword(int length) {
        String pwString = generateRandomSpecialCharacters(2)
                .concat(generateRandomNumbers(2))
                .concat(generateRandomAlphabet(2, true))
                .concat(generateRandomAlphabet(length-6, false));

        List<Character> pwChars = pwString.chars()
                .mapToObj(data -> (char) data)
                .collect(Collectors.toList());
        Collections.shuffle(pwChars);
        String password = pwChars.stream()
                .collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
                .toString();
        return password;
    }
    public String generateCharactersInRange(int length,int rangeStart, int rangeEnd) {
        RandomStringGenerator pwdGenerator = new RandomStringGenerator.Builder().withinRange(rangeStart, rangeEnd)
                .build();
        return pwdGenerator.generate(length);
    }
    public String generateRandomSpecialCharacters(int length) {
        return generateCharactersInRange(length, 33, 45);
    }
    public String generateRandomNumbers(int length) {
        return generateCharactersInRange(length, 48, 57);
    }
    public String generateRandomAlphabet(int length, boolean upperCase) {
        return generateCharactersInRange(length, upperCase ? 65 : 97, upperCase ? 90 : 122);
    }

}
