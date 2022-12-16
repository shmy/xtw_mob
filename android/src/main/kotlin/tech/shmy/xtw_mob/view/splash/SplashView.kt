package tech.shmy.xtw_mob.view.splash

import android.view.View
import android.widget.FrameLayout
import com.youxiao.ssp.ad.bean.SSPAd
import com.youxiao.ssp.ad.core.AdClient
import com.youxiao.ssp.ad.listener.AdLoadAdapter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import tech.shmy.xtw_mob.Constant
import tech.shmy.xtw_mob.XTW


class SplashView(
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<String?, Any?>?
) : PlatformView {
    private val container: FrameLayout = XTW.getEmptyContainer()
    private var methodChannel: MethodChannel? =
        MethodChannel(messenger, Constant.splashAdView + "_" + id)

    init {
        methodChannel?.invokeMethod("initializing", null)
        val adId = creationParams!!["id"] as String?
        val adClient = AdClient(XTW.activity)
        adClient.requestSplashAd(container, adId, object : AdLoadAdapter() {
            override fun onAdShow(p0: SSPAd?) {
                methodChannel?.invokeMethod("onShow", null)
                super.onAdShow(p0)
            }

            override fun onAdClick(p0: SSPAd?) {
                methodChannel?.invokeMethod("onClick", null)

                super.onAdClick(p0)
            }
            override fun onError(p0: Int, p1: String?) {
                methodChannel?.invokeMethod("onError", p1)
                super.onError(p0, p1)
            }

            override fun onAdDismiss(ad: SSPAd) {
                methodChannel?.invokeMethod("onDismiss", null)
                super.onAdDismiss(ad)
            }
        })

    }

    override fun getView(): View {
        return container
    }

    override fun dispose() {
        container.removeAllViews()
    }

}