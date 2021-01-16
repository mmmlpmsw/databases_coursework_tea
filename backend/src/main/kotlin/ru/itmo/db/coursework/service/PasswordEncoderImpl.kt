package ru.itmo.db.coursework.service

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.security.crypto.password.PasswordEncoder
import org.springframework.stereotype.Service
import java.security.MessageDigest
import java.io.ByteArrayOutputStream
import java.util.*

@Service("passwordEncoder")
class PasswordEncoderImpl @Autowired constructor(
        private val userPasswordSalt: ByteArray
): PasswordEncoder {
    override fun encode(raw: CharSequence): String {
        val digest = MessageDigest.getInstance("SHA-512")
        val outputStream = ByteArrayOutputStream()
        outputStream.write(raw.toString().toByteArray())
        outputStream.write(userPasswordSalt)

        return Base64.getEncoder().encodeToString(digest.digest(outputStream.toByteArray()))
    }

    override fun matches(raw: CharSequence?, hashed: String?): Boolean {
        return raw != null && hashed != null && encode(raw).contentEquals(hashed)
    }
}