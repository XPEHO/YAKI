package com.xpeho.yaki

import java.time.LocalDateTime

data class AlarmItem(
    val message: String,
    val title: String,
    val time: LocalDateTime,
)
