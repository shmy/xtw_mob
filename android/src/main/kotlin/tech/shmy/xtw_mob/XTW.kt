package tech.shmy.xtw_mob

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.widget.FrameLayout
import com.youxiao.ssp.ad.bean.SSPAd
import com.youxiao.ssp.ad.config.DownloadConfirmPolicy
import com.youxiao.ssp.ad.core.AdClient
import com.youxiao.ssp.ad.listener.AdLoadAdapter
import com.youxiao.ssp.ad.listener.RewardVideoAdAdapter
import com.youxiao.ssp.core.SSPSdk
import io.flutter.plugin.common.MethodChannel

@SuppressLint("StaticFieldLeak")
object XTW {
    lateinit var activity: Activity
    lateinit var context: Context
    fun getEmptyContainer(): FrameLayout {
        val layoutParams = FrameLayout.LayoutParams(
            FrameLayout.LayoutParams.MATCH_PARENT,
            FrameLayout.LayoutParams.MATCH_PARENT
        )
        val container = FrameLayout(context)
        container.layoutParams = layoutParams
        return container
    }
    fun initAd(appId: String, result: MethodChannel.Result) {
        SSPSdk.init(context, appId, false)
        SSPSdk.setReqPermission(true);
        SSPSdk.setDownloadConfirmPolicy(DownloadConfirmPolicy.CONFIRM_NONE)
        result.success(true)
    }

    fun insertAd(adCode: String, queuingEventSink: QueuingEventSink) {
        val adClient = AdClient(activity)
        adClient.requestInteractionAd(adCode, object : AdLoadAdapter() {
            override fun onAdClick(p0: SSPAd?) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.insertAd,
                        "event" to "onClick",
                    )
                )
                super.onAdClick(p0)
            }

            override fun onAdShow(p0: SSPAd?) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.insertAd,
                        "event" to "onShow",
                    )
                )
                super.onAdShow(p0)
            }

            override fun onError(i: Int, s: String) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.insertAd,
                        "event" to "onError",
                    )
                )
                super.onError(i, s)
                adClient.release()
            }

            override fun onAdDismiss(sspAd: SSPAd) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.insertAd,
                        "event" to "onDismiss",
                    )
                )
                super.onAdDismiss(sspAd)
                adClient.release()
            }
        })
    }

    fun rewardAd(adCode: String, userId: String, queuingEventSink: QueuingEventSink) {
        val adClient = AdClient(activity)
        adClient.requestRewardAd(adCode, object : RewardVideoAdAdapter() {
            override fun startPlayRewardVideo() {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onShow",
                    )
                )
                super.startPlayRewardVideo()
            }

            override fun rewardVideoButtonClick() {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onClick",
                    )
                )
                super.rewardVideoButtonClick()
            }

            override fun rewardVideoClick() {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onClick",
                    )
                )
                super.rewardVideoClick()
            }

            override fun loadRewardAdFail(p0: String?) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onError",
                    )
                )
                super.loadRewardAdFail(p0)
            }

            override fun loadRewardVideoFail(p0: Int, p1: Int) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onError",
                    )
                )
                super.loadRewardVideoFail(p0, p1)
            }
            override fun onReward(type: Int) {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onReward"
                    )
                )
                adClient.release()
            }

            override fun rewardVideoClosed() {
                queuingEventSink.success(
                    mapOf(
                        "type" to Constant.rewardAd,
                        "event" to "onDismiss",
                    )
                )
                super.rewardVideoClosed()
                adClient.release()
            }
        })
    }

}