from sqlalchemy.orm import DeclarativeBase, Mapped, declared_attr, mapped_column

DATABASE_URL = "sqlite+aiosqlite:///data.db"


class Base(DeclarativeBase):
    __abstract__ = True

    @declared_attr.directive
    def __tablename__(cls) -> str:
        return cls.__name__.lower()

    id: Mapped[int] = mapped_column(primary_key=True)


class CombinedData(Base):
    column1: Mapped[str]
    column2: Mapped[str]
