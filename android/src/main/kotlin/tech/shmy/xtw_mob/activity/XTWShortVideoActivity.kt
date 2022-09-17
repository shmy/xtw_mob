package tech.shmy.xtw_mob.activity

import android.graphics.Color
import android.os.Bundle
import android.widget.TextView
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import com.youxiao.ssp.core.SSPSdk
import tech.shmy.xtw_mob.R


class XTWShortVideoActivity : FragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val extras = intent.extras!!
        setContentView(R.layout.xtw_short_video_activity)
        findViewById<TextView>(R.id.back_button).apply {
            textSize = 18f
            text = extras.getString("backText")
            setTextColor(Color.WHITE)
            setShadowLayer(1F, 0F, 0F, Color.BLACK);
            setOnClickListener {
                finish()
            }
        }
        val contentFragment: Fragment = SSPSdk.getContent()
        supportFragmentManager.beginTransaction().replace(R.id.fragment_container, contentFragment).commitAllowingStateLoss();
    }
}