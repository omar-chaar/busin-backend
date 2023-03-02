
from sqlalchemy import Column, Integer, String
from sqlalchemy.types import Date
from .database import Base


class Message(Base):
    __tablename__ = "Message"

    message_id = Column(Integer, primary_key=True, index=True)
    sender_id = Column(Integer)
    country = Column(String(255), index=True)
    cases = Column(Integer)
    deaths = Column(Integer)
    recoveries = Column(Integer)