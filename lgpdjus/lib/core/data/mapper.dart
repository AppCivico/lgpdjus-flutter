abstract class IMapper<In, Out> {
  Out call(In source);
}

typedef Out Mapper<In, Out>(In source);