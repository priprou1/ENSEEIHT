import java.lang.annotation.*;


@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface UnTest {
    boolean enabled() default true;
    Class<? extends Throwable> expected() default NoExceptionExpected.class;

    public static class NoExceptionExpected extends Throwable {}

}
