# 4/29 Apache Kafka - Consumer

Date: April 29, 2022 10:31 PM

### Consumer

- 토픽을 카프카에서 가져오는 어플리케이션
- 카프카의 경우 다른 메세징 시스템과는 다르게 큐에서 데이터를 가져가도 데이터가 사라지지 않는다.
- 데이터를 가져오는 것을 polling이라고 한다.
- 역할
    - Topic의 partition으로부터 데이터 polling
    - Partition offset 위치 기록(commit)
    - Consumer group을 통해 병렬처리

```java
public class Consumer {
	public static void main(String[] args){
		Properties configs = new Properties();
		configs.put("bootstrap.servers", "localhost:9092");// 카프카 브로커 설정
		configs.put("group.id", "click_log_group"); //consumer group의 id
		configs.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		// Key는 토픽의 파티션을 지정해줄 때 쓰인다
		configs.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		
		KafkaConsumer<String, String> consumer = new KafkaConsumer<String, String>(configs);

		consumer.subscribe(Arrays.asList("click_log")); //파티션 설정 - 전체 파티션

		TopicPattern partition0 = new TopicPatition(topicName, 0);
		TopicPattern partition1 = new TopicPatition(topicName, 1);
		consumer.assign(Arrays.asList(partition0, partition1)) // 토픽 설정 - 0,1 파티션만

		while(true){
			ConsumerRecords<String, String> records = consumer.poll(500); //500ms 마다 가져옴
			for(ConsumerRecord<String, String> record : records) {
				// 데이터가 없는 경우 records는 비어있다.
				System.out.println(record.value());
			}
		}
	}
}
```

- offset = 컨슈머가 어디까지 읽었는가, 하나의 컨슈머가 다운 되더라도 다음 데이터를 읽을 수 있다.
    - 다른 컨슈머 그룹이 같은 데이터에 접근하더라도 off-set을 통해 데이터 중복 처리 없이 배분할 수 있다.
- 컨슈머 그룹과 partition과의 데이터 처리
    - partition 2개, consumer 1개인 경우 컨슈머에서 2개의 파티션에서 병렬처리
    - partition 2개, consumer 2개인 경우 2개의 컨슈머가 2개의 파티션에서 각각 데이터를 가져가서 처리
    - partition 2개, consumer 3개인 경우 1개의 컨슈머는 잉여

### Lag

- 프로듀서의 오프셋과 컨슈머 오프셋간의 차이. (Producer의 속도가 너무 빠를 경우 lag이 커짐)
- 복수개로 존재할 수 있다.

### Burrow

- Lag을 수집하기 위해 Linkedin에서 개발한 오픈소스 애플리케이션
- 특징
    - 멀티 카프카 클러스터 지원
    - Sliding window를 통한 Consumer의 status확인
        - 데이터양이 많아져서 consumer off-set이 많아지면 - WARNING
        - consumer가 데이터를 가져가지 않으면 - ERROR
    - HTTP API 제공