package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.lang.reflect.Field;
import java.util.ArrayList;

public class StatisticsCsvConverter {

    /**
     * Convert StatisticsEntity to CSV content
     *
     * @param statisticsEntity : StatisticsEntity to convert
     * @return : CSV content
     */
    public static String convertToCsvContent(StatisticsEntity statisticsEntity) {
        StringBuilder csvContent = initCsvContent();
        addKeysToCsvContent(csvContent, statisticsEntity);
        addValuesToCsvContent(csvContent, statisticsEntity);
        return csvContent.toString();
    }

    /**
     * Convert StatisticsEntity list to CSV content
     *
     * @param statisticsEntities : StatisticsEntity list to convert
     * @return : CSV content
     */
    public static String convertListToCsvContent(ArrayList<? extends StatisticsEntity> statisticsEntities) {
        if (statisticsEntities.isEmpty()) {
            return null;
        }
        StringBuilder csvContent = initCsvContent();
        addKeysToCsvContent(csvContent, statisticsEntities.get(0));
        for (StatisticsEntity statisticsEntity : statisticsEntities) {
            addValuesToCsvContent(csvContent, statisticsEntity);
        }
        return csvContent.toString();
    }

    /**
     * Init CSV content
     *
     * @return : StringBuilder
     */
    private static StringBuilder initCsvContent() {
        return new StringBuilder();
    }

    /**
     * Add StatisticsEntity attribute to CSV content as headers
     *
     * @param csvContent : StringBuilder that contains the CSV content
     * @param statisticsEntity : StatisticsEntity that contains the attributes
     * @return : CSV content with headers
     */
    private static void addKeysToCsvContent(StringBuilder csvContent, StatisticsEntity statisticsEntity) {
        // Init keys
        ArrayList<String> keys = new ArrayList<>();
        for (Field field : statisticsEntity.getClass().getDeclaredFields()) {
            field.setAccessible(true);
            // Get keys
            String key = camelCaseToSentence(field.getName());
            // Add keys
            keys.add(key);
        }
        // Add keys to CSV content
        csvContent.append(String.join(",", keys));
        csvContent.append("\n");
    }

    /**
     * Add StatisticsEntity values to CSV content
     *
     * @param csvContent : StringBuilder that contains the CSV content
     * @param statisticsEntity : StatisticsEntity that contains the values
     * @return : CSV content with values
     */
    private static void addValuesToCsvContent(StringBuilder csvContent, StatisticsEntity statisticsEntity) {
        // Init values
        ArrayList<String> values = new ArrayList<>();
        for (Field field : statisticsEntity.getClass().getDeclaredFields()) {
            field.setAccessible(true);
            try {
                // Get values
                String value = String.valueOf(field.get(statisticsEntity));
                // Add values
                values.add(value);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
        // Add values to CSV content
        csvContent.append(String.join(",", values));
        csvContent.append("\n");
    }

    /**
     * Convert camelCase to sentence
     *
     * @param camelCase : String to convert
     * @return : String converted
     */
    private static String camelCaseToSentence(String camelCase) {
        // Make a sentence from camelCase
        String result = camelCase.replaceAll("([a-z])([A-Z])", "$1 $2");
        // Lowercase all letters
        result = result.toLowerCase();
        // Capitalize first letter
        result = result.substring(0, 1).toUpperCase() + result.substring(1);
        return result;
    }
}
