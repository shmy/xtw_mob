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
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

@SuppressLint("StaticFieldLeak")
object XTW {
    lateinit var activity: Activity
    lateinit var context: Context
    private var insertAdId = -1
    private var rewardAdId = -1
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

    fun insertAd(adCode: String, binaryMessenger: BinaryMessenger, result: MethodChannel.Result) {
        val adClient = AdClient(activity)
        insertAdId ++
        val eventChannel = EventChannel(binaryMessenger, "insertAdEvent_$insertAdId")
        var eventSink: EventChannel.EventSink? = null
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }

        })
        result.success(insertAdId)
        adClient.requestInteractionAd(adCode, object : AdLoadAdapter() {
            override fun onAdClick(p0: SSPAd?) {
                eventSink?.success(
                    mapOf(
                        "event" to "onClick",
                    )
                )
                super.onAdClick(p0)
            }

            override fun onAdShow(p0: SSPAd?) {
                eventSink?.success(
                    mapOf(
                        "event" to "onShow",
                    )
                )
                super.onAdShow(p0)
            }

            override fun onError(i: Int, s: String) {
                eventSink?.success(
                    mapOf(
                        "event" to "onError",
                    )
                )
                eventSink?.endOfStream()
                super.onError(i, s)
                adClient.release()
            }

            override fun onAdDismiss(sspAd: SSPAd) {
                eventSink?.success(
                    mapOf(
                        "event" to "onDismiss",
                    )
                )
                eventSink?.endOfStream()
                super.onAdDismiss(sspAd)
                adClient.release()
            }
        })
    }

    fun rewardAd(adCode: String, userId: String, binaryMessenger: BinaryMessenger, result: MethodChannel.Result) {
        val adClient = AdClient(activity)
        rewardAdId ++

        val eventChannel = EventChannel(binaryMessenger, "rewardAdEvent_$rewardAdId")
        var eventSink: EventChannel.EventSink? = null
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler{
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }

        })
        result.success(rewardAdId)
        adClient.requestRewardAd(adCode, object : RewardVideoAdAdapter() {
            override fun startPlayRewardVideo() {
                eventSink?.success(
                    mapOf(
                        "event" to "onShow",
                    )
                )
                super.startPlayRewardVideo()
            }

            override fun rewardVideoButtonClick() {
                eventSink?.success(
                    mapOf(
                        "event" to "onClick",
                    )
                )
                super.rewardVideoButtonClick()
            }

            override fun rewardVideoClick() {
                eventSink?.success(
                    mapOf(
                        "event" to "onClick",
                    )
                )
                super.rewardVideoClick()
            }

            override fun loadRewardAdFail(p0: String?) {
                eventSink?.success(
                    mapOf(
                        "event" to "onError",
                    )
                )
                eventSink?.endOfStream()
                adClient.release()
            }

            override fun loadRewardVideoFail(p0: Int, p1: Int) {
                eventSink?.success(
                    mapOf(
                        "event" to "onError",
                    )
                )
                eventSink?.endOfStream()
                adClient.release()
            }

            override fun onReward(type: Int) {
                eventSink?.success(
                    mapOf(
                        "event" to "onReward"
                    )
                )
                eventSink?.endOfStream()
                adClient.release()
            }

            override fun rewardVideoClosed() {
                eventSink?.success(
                    mapOf(
                        "event" to "onDismiss",
                    )
                )
                eventSink?.endOfStream()
                super.rewardVideoClosed()
                adClient.release()
            }
        })
    }

}