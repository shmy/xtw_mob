package tech.shmy.xtw_mob.view.feed

import android.annotation.SuppressLint
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import com.bumptech.glide.Glide
import com.youxiao.ssp.ad.bean.SSPAd
import com.youxiao.ssp.ad.core.AdClient
import com.youxiao.ssp.ad.listener.AdLoadAdapter
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import tech.shmy.xtw_mob.Constant
import tech.shmy.xtw_mob.Constant.feedAdView
import tech.shmy.xtw_mob.XTW


class FeedView(
    messenger: BinaryMessenger,
    id: Int,
    creationParams: Map<String?, Any?>?
) : PlatformView {
    private val imageView = ImageView(XTW.context)
    private val container: LinearLayout = XTW.getEmptyContainer()
    private var methodChannel: MethodChannel? =
        MethodChannel(messenger, Constant.feedAdView + "_" + id)

    init {
        methodChannel?.invokeMethod("initializing", null)
        val adId = creationParams!!["id"] as String?
        val listener: AdLoadAdapter = object : AdLoadAdapter() {
            override fun onAdClick(p0: SSPAd?) {
                methodChannel?.invokeMethod("onClick", null)
                super.onAdClick(p0)
            }

            override fun onAdShow(p0: SSPAd?) {
                methodChannel?.invokeMethod("onShow", null)
                super.onAdShow(p0)
            }

            override fun onAdLoad(p0: SSPAd?) {
                methodChannel?.invokeMethod("onLoad", null)
                super.onAdLoad(p0)
            }

            override fun onError(i: Int, s: String) {
                methodChannel?.invokeMethod("onError", s)
                super.onError(i, s)
            }

            override fun onAdDismiss(sspAd: SSPAd) {
                methodChannel?.invokeMethod("onDismiss", null)
                super.onAdDismiss(sspAd)
            }
        }
        val adClient = AdClient(XTW.activity)
        adClient.requestFeedAd(adId, object : AdLoadAdapter() {
            @SuppressLint("CheckResult")
            override fun onAdLoad(p0: SSPAd?) {
                super.onAdLoad(p0)
                Glide.with(container).load(p0?.img).into(imageView);
                container.addView(imageView)
                adClient.registerView(container, p0?.adInfo, listener)
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