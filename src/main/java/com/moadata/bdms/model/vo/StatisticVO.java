package com.moadata.bdms.model.vo;

import com.moadata.bdms.common.base.vo.BaseObject;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;

/**
 * Request
 */
@Getter
@Setter
@Alias("statisticVO")
public class StatisticVO extends BaseObject {
	/** The Constant serialVersionUID. */
	private static final long serialVersionUID = 7548909224535899059L;

	private String timestamp;

	/* User Amount */
	private int inOut;

	/* Service Request */
	private int nursing;
	private int ambulance;
	private int consultation;

	/* Health Alert */
	private int activity;
	private int falls;
	private int heartRate;
	private int sleep;
	private int bloodOxygen;
	private int temperature;
	private int stress;

	public StatisticVO(){}

	public StatisticVO(String timestamp, int inOut) {
		this.timestamp = timestamp;
		this.inOut = inOut;
	}

	public StatisticVO(String timestamp, int nursing, int ambulance, int consultation) {
		this.timestamp = timestamp;
		this.nursing = nursing;
		this.ambulance = ambulance;
		this.consultation = consultation;
	}

	public StatisticVO(String timestamp, int activity, int falls, int heartRate, int sleep, int bloodOxygen, int temperature, int stress) {
		this.timestamp = timestamp;
		this.activity = activity;
		this.falls = falls;
		this.heartRate = heartRate;
		this.sleep = sleep;
		this.bloodOxygen = bloodOxygen;
		this.temperature = temperature;
		this.stress = stress;
	}

}
