# 1/3 RxJava - Flowable, Observable, Single, Maybe, Completable

### Flowable

```java
public static void main(String[] args) throws InterruptedException {
    Flowable<String> flowable =
            Flowable.create(new FlowableOnSubscribe<String>() {
                @Override
                public void subscribe(FlowableEmitter<String> emitter) throws Exception {
                    String[] datas = {"Hello", "RxJava!"};
                    for(String data : datas) {
                        // 구독이 해지되면 처리 중단
                        if (emitter.isCancelled())
                            return;

                        // 데이터 통지
                        emitter.onNext(data);
                    }

                    // 데이터 통지 완료를 알린다
                    emitter.onComplete();
                }
            }, BackpressureStrategy.BUFFER); // 구독자의 처리가 늦을 경우 데이터를 버퍼에 담아두는 설정.

    flowable.observeOn(Schedulers.computation())
            .subscribe(new Subscriber<String>() {
                // 데이터 개수 요청 및 구독을 취소하기 위한 Subscription 객체
                private Subscription subscription;

                @Override
                public void onSubscribe(Subscription subscription) {
                        this.subscription = subscription;
                        this.subscription.request(Long.MAX_VALUE);
                }

                @Override
                public void onNext(String data) {
                    Logger.log(LogType.ON_NEXT, data);
                }

                @Override
                public void onError(Throwable error) {
                    Logger.log(LogType.ON_ERROR, error);
                }

                @Override
                public void onComplete() {
                    Logger.log(LogType.ON_COMPLETE);
                }
            });

    Thread.sleep(500L);
}
```

### Observable

```java
public static void main(String[] args) throws InterruptedException {
    Observable<String> observable =
            Observable.create(new ObservableOnSubscribe<String>() {
                @Override
                public void subscribe(ObservableEmitter<String> emitter) throws Exception {
                    String[] datas = {"Hello", "RxJava!"};
                    for(String data : datas){
                        if(emitter.isDisposed())
                            return;

                        emitter.onNext(data);
                    }
                    emitter.onComplete();
                }
            });

    observable.observeOn(Schedulers.computation())
            .subscribe(new Observer<String>() {
        @Override
        public void onSubscribe(Disposable disposable) {
            // 아무 처리도 하지 않음.
        }

        @Override
        public void onNext(String data) {
            Logger.log(LogType.ON_NEXT, data);
        }

        @Override
        public void onError(Throwable error) {
            Logger.log(LogType.ON_ERROR, error);
        }

        @Override
        public void onComplete() {
            Logger.log(LogType.ON_COMPLETE);
        }
    });

    Thread.sleep(500L);
}
```

### Single

- 데이터를 1건만 통지하거나 에러를 통지한다
- 데이터 통지 자체가 완료를 의미하기 때문에 완료 통지는 하지 않는다
- 데이터를 1건만 통지하므로 데이터 개수를 요청할 필요가 없다
- onNext(), onComplete()가 없으며 이 둘을 합한 onSuccess()를 제공한다
- Single의 대표적인 소비자는 SingleObserver이다
- 클라이언트 요청에 대응하는 서버의 응답이 Single을 사용하기 좋은 대표적인 예다

```java
Single<String> single = Single.create(new SingleOnSubscribe<String>() {
    @Override
    public void subscribe(SingleEmitter<String> emitter) throws Exception {
        emitter.onSuccess(DateUtil.getNowDate());
    }
});

single.subscribe(new SingleObserver<String>() {
    @Override
    public void onSubscribe(Disposable disposable) {
        // 아무것도 하지 않음.
    }

    @Override
    public void onSuccess(String data) {
        Logger.log(LogType.ON_SUCCESS, "# 날짜시각: " + data);
    }

    @Override
    public void onError(Throwable error) {
        Logger.log(LogType.ON_ERROR, error);
    }
});
```

### Maybe

- 데이터를 1건만 통지하거나 1건도 통지하지 않고 완료 또는 에러를 통지한다
- 데이터 통지 자체가 완료를 의미하기 때문에 완료 통지는 하지 않는다
- 단, 데이터를 1건도 통지하지 않고 처리가 종료될 경우에는 완료 통지를 한다
- Maybe의 대표적인 소비자는 MaybeObserver이다

```java
Maybe<String> maybe = Maybe.create(new MaybeOnSubscribe<String>() {
        @Override
        public void subscribe(MaybeEmitter<String> emitter) throws Exception {
//                emitter.onSuccess(DateUtil.getNowDate()); <- 데이터가 통지 되는 경우

            emitter.onComplete(); <- 데이터가 통지 되지 않는 경우
        }
    });

    maybe.subscribe(new MaybeObserver<String>() {
        @Override
        public void onSubscribe(Disposable disposable) {
            // 아무것도 하지 않음.
        }

        @Override
        public void onSuccess(String data) {
            Logger.log(LogType.ON_SUCCESS, "# 현재 날짜시각: " + data);
        }

        @Override
        public void onError(Throwable error) {
            Logger.log(LogType.ON_ERROR, error);
        }

        @Override
        public void onComplete() {
            Logger.log(LogType.ON_COMPLETE);
        }
    });
}
```

** Single to Maybe

```java
Single<String> single = Single.just(DateUtil.getNowDate());
	Maybe.fromSingle(single)
	        .subscribe(
	                data -> Logger.log(LogType.ON_SUCCESS, "# 현재 날짜시각: " + data),
	                error -> Logger.log(LogType.ON_ERROR, error),
	                () -> Logger.log(LogType.ON_COMPLETE)
	        );
```

### Completable

- 데이터 생산자이지만 데이터를 1건도 통지하지 않고 완료 또는 에러를 통지한다.
- 데이터 통지의 역할 대신에 Completable 내에서 특정작업을 수행한 후, 해당 처리가 끝났음을 통지하는 역할을 한다.
- Completable의 대표적인 소비자는 CompletableObserver이다.

```java
Completable completable = Completable.create(new CompletableOnSubscribe() {
        @Override
        public void subscribe(CompletableEmitter emitter) throws Exception {
            // 데이터를 통지하는것이 아니라 특정 작업을 수행한 후, 완료를 통지한다.
            int sum = 0;
            for(int i =0; i < 100; i++){
                sum += i;
            }
            Logger.log(LogType.PRINT, "# 합계: " + sum);

            emitter.onComplete();
        }
    });

    completable.subscribeOn(Schedulers.computation())
            .subscribe(new CompletableObserver() {
        @Override
        public void onSubscribe(Disposable disposable) {
            // 아무것도 하지 않음
        }

        @Override
        public void onComplete() {
            Logger.log(LogType.ON_COMPLETE);
        }

        @Override
        public void onError(Throwable error) {
            Logger.log(LogType.ON_ERROR, error);
        }
    });

    TimeUtil.sleep(100L);
}
```